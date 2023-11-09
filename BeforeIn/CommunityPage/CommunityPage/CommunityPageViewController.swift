//
//  CommunityPageViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/20.
//

import UIKit
import FirebaseFirestore

class CommunityPageViewController: BaseViewController {
    
    // MARK: - Properties
    private let communityPageView = CommunityPageView()
    var post: Post!
    var comments = [Comment]()
    let db = Firestore.firestore()
    let userManager = UserManager()
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = communityPageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        fetchPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityPageView.communityPageViewModel = CommunityPageViewModel(post: post)
        setTableView()
        addTarget()
        setTextField()
        //        loadComments()
    }
    
    
    // MARK: - Methods
    func setTableView(){
        communityPageView.commentTableView.delegate = self
        communityPageView.commentTableView.dataSource = self
        communityPageView.commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    }
    
    func addTarget(){
        communityPageView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        communityPageView.blockButton.addTarget(self, action: #selector(blockButtonTapped), for: .touchUpInside)
        communityPageView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        communityPageView.reportButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
    }
    
    func setTextField(){
        communityPageView.commentTextField.delegate = self
    }
    
    
    
    // MARK: - @objc
    @objc func moreButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            let post = self.post
            let modifyVC = ModifyViewController()
            modifyVC.post = post
            self.navigationController?.pushViewController(modifyVC, animated: true)
        }

        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            let alert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: "삭제하시면 복구가 불가능합니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "예" , style: .destructive) { _ in
                self.db.collection("Post").document(self.post.postID).delete()
                self.navigationController?.popViewController(animated: true)
            }
            let cancel = UIAlertAction(title: "아니오", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            actionSheet.dismiss(animated: true)
        }

        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true)
    }
    
    @objc func sendButtonTapped() {
        if let commentText = communityPageView.commentTextField.text?.trimmingCharacters(in: .whitespaces), !commentText.isEmpty {
            addComment(comment: commentText)
            DispatchQueue.main.async {
                self.communityPageView.commentTextField.text = ""
            }
        }
    }
    
    @objc func reportButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "신고하시면 취소가 불가능합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "신고", style: .destructive) { _ in
            if !self.post.reportUserList.contains(currentUser.email) {
                self.post.reportUserList.append(currentUser.email)
                self.db.collection("Post").document(self.post.postID).updateData(["reportUserList": self.post.reportUserList]) { error in
                    if let error = error {
                        print("Error updating reportUserList in Firestore: \(error.localizedDescription)")
                    } else {
                        print("추가 성공")
                    }
                }
            } else {
                let alert = UIAlertController(title: "신고못해요", message: "이미신고햇거든여", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    // 차단
    @objc func blockButtonTapped() {
        showAlertTwoButton(title: "사용자 차단", message: "해당 사용자를 차단하시겠습니까?", button1Title: "확인", button2Title: "취소") {
            let blockEmail = self.post.writer
            self.userManager.addToBlockList(userEmail: blockEmail)
            self.showAlertOneButton(title: "차단 완료", message: "차단 완료되었습니다.", buttonTitle: "확인"){
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // 댓글 fireStore에 저장
    func addComment(comment: String) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        let writer = currentUser.email
        var writerNickName = currentUser.nickname
        let content = comment
        let postingTime = Date()
        var writerRef: DocumentReference?
        let query = db.collection("User").whereField("email", isEqualTo: writer)
        query.getDocuments{ (snapshot, error) in
            let docs = snapshot!.documents
            for doc in docs {
                writerRef = self.db.collection("User").document(doc.documentID)
                if let nickname = doc.get("nickname") as? String{
                    writerNickName = nickname
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            
            let newComment = Comment(writer: writer, writerNickName: writerNickName, content: content, postingTime: postingTime, reportUserList: [], writerRef: writerRef)
            self.post.comments.append(newComment)
            let commentsData: [[String: Any]] = self.post.comments.map { comment in
                return [
                    "writer": comment.writer,
                    "writerNickName": comment.writerNickName,
                    "content": comment.content,
                    "postingTime": comment.postingTime,
                    "reportUserList": comment.reportUserList,
                    "writerRef": comment.writerRef
                ]
            }
            
            self.db.collection("Post").document(self.post.postID).updateData(["comments": commentsData]) { error in
                if let error = error {
                    print("Error updating comments in Firestore: \(error.localizedDescription)")
                } else {
                    print("Comments updated successfully")
                }
            }
        }
        

    }
    
    func fetchPost() {
        db.collection("Post").document(post.postID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if document.exists {
                let dispatchGroup = DispatchGroup()
                let data = document.data() ?? [:]
                let category = data["category"] as? String ?? ""
                let likes = data["likes"] as? Int ?? 0
                let postingTime = data["postingTime"] as? Timestamp ?? Timestamp(date: Date())
                let postingID = data["postingID"] as? String ?? ""
                let writer = data["writer"] as? String ?? ""
                var writerNickName = ""
                
                if let writerRef = data["writerNickName"] as? DocumentReference {
                    dispatchGroup.enter()
                    writerRef.getDocument{ (snapshot, error) in
                        if let data = snapshot?.data() {
                            if let nickname = data["nickname"] as? String {
                                writerNickName = nickname
                                dispatchGroup.leave()
                            }
                        }
                        
                    }
                }
                
                var comments: [Comment] = []
                if let commentsData = data["comments"] as? [[String: Any]] {
                    for comment in commentsData {
                        if let commentWriter = comment["writer"] as? String,
                           let commentPostingTime = comment["postingTime"] as? Timestamp,
                           var commentContent = comment["content"] as? String,
//                           var commentWriterNickName = comment["writerNickName"] as? String,
                           let commentWriterRef = comment["writerRef"] as? DocumentReference {
                            var commentWriterNickName = ""
                            dispatchGroup.enter()
                            
                            commentWriterRef.getDocument{ (snapshot, error) in
                                if error == nil && snapshot != nil{
                                    if let data = snapshot!.data() {
                                        if let nickname = data["nickname"] as? String {
                                            commentWriterNickName = nickname
                                            dispatchGroup.leave()
                                        }
                                    }
                                    else {
                                        commentWriterNickName = "탈퇴한 회원"
                                        dispatchGroup.leave()
                                    }
                                    
                                }
                            }
                            var reportUserList: [String] = []
                            if let reportData = comment["reportUserList"] as? [String] {
                                reportUserList = reportData
                            }
                            if reportUserList.count >= 1 {
                                commentContent = "신고누적으로 삭제된 댓글입니다."
                            }
                            
                            dispatchGroup.notify(queue: .main) {
                                let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue(), reportUserList: reportUserList, writerRef: commentWriterRef)
                                comments.append(newComment)
                            }
                            
                        }
                    }
                }
                var reportUserList: [String] = []
                let reportedData = data["reportUserList"] as? [String]
                if let reportedData = reportedData {
                    for email in reportedData {
                        reportUserList.append(email)
                    }
                }
                var title = data["title"] as? String ?? ""
                var content = data["content"] as? String ?? ""
                if reportUserList.count >= 1 {
                    title = "신고당한 글이라 삭제됨"
                    content = "신고당한 글이라 삭제됨"
                }
                
                dispatchGroup.notify(queue: .main) {
                    print(writerNickName)
                    let fetchedPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue(), reportUserList: reportUserList)
                    self.post = fetchedPost
                    self.communityPageView.communityPageViewModel?.updatePost(fetchedPost)
                    self.communityPageView.commentTableView.reloadData()
                    print("패치완료")
                }
                
            }
        }
    }
    
    
    
}



// MARK: - UITableViewDelegate
extension CommunityPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}


// MARK: - UITableViewDataSource
extension CommunityPageViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = post.comments[indexPath.row]
        if currentUser.blockList.contains(comment.writer){
            cell.isHidden = true
        }
        else {
            let dateString = comment.postingTime.getTimeText()
            cell.dateLabel.text = dateString
            cell.commentLabel.text = comment.content
            cell.authorLabel.text = comment.writerNickName
            
            if currentUser.email == comment.writer {
                cell.editButton.isHidden = false
                cell.deleteButton.isHidden = false
                cell.reportButton.isHidden = true
                
                cell.editButton.tag = indexPath.row
                cell.deleteButton.tag = indexPath.row
                cell.editButton.addTarget(self, action: #selector(commentEditButtonTapped), for: .touchUpInside)
                cell.deleteButton.addTarget(self, action: #selector(commentDeleteButtonTapped), for: .touchUpInside)
            } else {
                cell.editButton.isHidden = true
                cell.deleteButton.isHidden = true
                
                cell.reportButton.isHidden = false
                cell.reportButton.tag = indexPath.row
                cell.reportButton.addTarget(self, action: #selector(commentReportButtonTapped), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    @objc func commentEditButtonTapped(_ sender: UIButton) {
        let comment = post.comments[sender.tag]
        let alert = UIAlertController(title: "댓글을 수정하시겠습니까?", message: "수정 후에는 복구가 불가능합니다." , preferredStyle: .alert)
        alert.addTextField() {
            $0.text = comment.content
        }
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            for i in 0..<self.post.comments.count{
                if comment == self.post.comments[i] {
                    guard let editContent = alert.textFields?[0].text else { return }
                    self.post.comments[i].content = editContent
                    let commentsData: [[String: Any]] = self.post.comments.map { comment in
                        return [
                            "writer": comment.writer,
                            "writerNickName": comment.writerNickName,
                            "content": comment.content,
                            "postingTime": comment.postingTime,
                            "writerRef": comment.writerRef
                        ]
                    }
                    
                    self.db.collection("Post").document(self.post.postID).updateData(["comments": commentsData]) { error in
                        if let error = error {
                            print("Error updating comments in Firestore: \(error.localizedDescription)")
                        } else {
                            print("수정 성공")
                        }
                    }
                    break
                }
            }
            
            
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func commentDeleteButtonTapped(_ sender: UIButton) {
        
        let comment = post.comments[sender.tag]
        let alert = UIAlertController(title: "댓글을 삭제하시겠습니까?", message: "삭제 후에는 복구가 불가능합니다." , preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .destructive) {_ in
            for i in 0..<self.post.comments.count{
                if comment == self.post.comments[i] {
                    self.post.comments.remove(at: i)
                    let commentsData: [[String: Any]] = self.post.comments.map { comment in
                        return [
                            "writer": comment.writer,
                            "writerNickName": comment.writerNickName,
                            "content": comment.content,
                            "postingTime": comment.postingTime,
                            "writerRef": comment.writerRef
                        ]
                    }
                    
                    self.db.collection("Post").document(self.post.postID).updateData(["comments": commentsData]) { error in
                        if let error = error {
                            print("Error updating comments in Firestore: \(error.localizedDescription)")
                        } else {
                            print("삭제 성공")
                        }
                    }
                    break
                }
            }
            
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }


    @objc func commentReportButtonTapped(_ sender: UIButton) {
        let comment = post.comments[sender.tag]
        let alert = UIAlertController(title: "이 댓글을 신고하시겠습니까?", message: "신고하시면 취소가 불가능합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "신고" , style: .destructive) { _ in
            for i in 0..<self.post.comments.count{
                if comment == self.post.comments[i] {
                    if !self.post.comments[i].reportUserList.contains(currentUser.email){
                        self.post.comments[i].reportUserList.append(currentUser.email)
                        let commentsData: [[String: Any]] = self.post.comments.map { comment in
                            return [
                                "writer": comment.writer,
                                "writerNickName": comment.writerNickName,
                                "content": comment.content,
                                "reportUserList": comment.reportUserList,
                                "postingTime": comment.postingTime,
                                "writerRef": comment.writerRef
                            ]
                        }
                        self.db.collection("Post").document(self.post.postID).updateData(["comments": commentsData]) { error in
                            if let error = error {
                                print("Error updating comments in Firestore: \(error.localizedDescription)")
                            } else {
                                print("추가 성공")
                            }
                        }
                        break
                    } else {
                        let alert = UIAlertController(title: "신고모ㅅ해요", message: "이미신고햇거든여", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension CommunityPageViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == communityPageView.commentTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -330
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}

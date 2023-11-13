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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Methods
    func setTableView(){
        communityPageView.commentTableView.delegate = self
        communityPageView.commentTableView.dataSource = self
        communityPageView.commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    }
    
    func addTarget(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        communityPageView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        communityPageView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    func setTextField(){
        communityPageView.commentTextField.delegate = self
    }
    
    
    
    // MARK: - @objc
    @objc func keyboardWillAppear(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
               let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                
                let contentInsetBottom = keyboardSize.height

                UIView.animate(withDuration: duration) {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
                    self.communityPageView.scrollView.contentInset.top = contentInsetBottom
                }
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sendButtonTapped))
            communityPageView.sendButton.addGestureRecognizer(tapGesture)
            communityPageView.sendButton.isUserInteractionEnabled = true
    }
    
    @objc func keyboardWillDisappear(notification: Notification) {
        if let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                UIView.animate(withDuration: duration) {
                    self.view.transform = .identity
                    self.communityPageView.scrollView.contentInset.top = 0
                }
            }
    }
    
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
        
        let blockAction = UIAlertAction(title: "유저 차단", style: .destructive) { _ in
            self.showAlertTwoButton(title: "사용자 차단", message: "해당 사용자를 차단하시겠습니까?", button1Title: "확인", button2Title: "취소") {
                let blockEmail = self.post.writer
                self.userManager.addToBlockList(userEmail: blockEmail)
                self.showAlertOneButton(title: "차단 완료", message: "차단 완료되었습니다.", buttonTitle: "확인"){
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        let reportAction = UIAlertAction(title: "게시글 신고", style: .destructive) { _ in
            let alert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "신고하시면 취소가 불가능합니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "신고", style: .destructive) { _ in
                if !self.post.reportUserList.contains(currentUser.email) {
                    self.post.reportUserList.append(currentUser.email)
                    self.db.collection("Post").document(self.post.postID).updateData(["reportUserList": self.post.reportUserList]) { error in
                        if let error = error {
                            print("Error updating reportUserList in Firestore: \(error.localizedDescription)")
                        } else {
                            self.showAlertOneButton(title: "게시글 신고", message: "해당 게시글이 신고되었습니다.", buttonTitle: "확인")
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "실패", message: "이미 신고한 게시물은 다시 신고할 수 없습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            actionSheet.dismiss(animated: true)
        }
        
        if currentUser.email == communityPageView.communityPageViewModel?.writerEmail {
            actionSheet.addAction(editAction)
            actionSheet.addAction(deleteAction)
        } else {
            actionSheet.addAction(blockAction)
            actionSheet.addAction(reportAction)
        }
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
                            if reportUserList.count >= 3 {
                                commentContent = "다수의 신고에 의해 삭제된 댓글입니다."
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
                if reportUserList.count >= 3 {
                    title = "다수의 신고에 의해 삭제된 게시물입니다."
                    content = "다수의 신고에 의해 삭제된 게시물입니다."
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
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        view.endEditing(true)
    //    }
    
}


// MARK: - UITableViewDataSource
extension CommunityPageViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        tableView.snp.updateConstraints {
        //            $0.height.equalTo(post.comments.count * 50) // TODO: - 카운트로 곱하는게아닌 모든댓글의 총합 높이를 구해서.. 댓글줄수가 각각다르니까 모든댓글의 사이즈를 구해서 업데이트 하는 식으로
        //        }
        return post.comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = post.comments[indexPath.row]
        let dateString = comment.postingTime.getTimeText()
        cell.dateLabel.text = dateString
        if currentUser.blockList.contains(comment.writer){
            cell.commentLabel.text = "차단된 사용자의 댓글입니다."
            cell.authorLabel.text = "차단된 사용자"
        }
        else {
            cell.commentLabel.text = comment.content
            cell.authorLabel.text = comment.writerNickName
        }
        if currentUser.email == comment.writer {
            cell.moreButton.isHidden = false
            cell.reportButton.isHidden = true
            
            cell.moreButton.tag = indexPath.row
            cell.moreButton.addTarget(self, action: #selector(commentMoreButtonTapped), for: .touchUpInside)
            //                cell.deleteButton.addTarget(self, action: #selector(commentDeleteButtonTapped), for: .touchUpInside)
        } else {
            cell.moreButton.isHidden = true
            
            cell.reportButton.isHidden = false
            cell.reportButton.tag = indexPath.row
            cell.reportButton.addTarget(self, action: #selector(commentReportButtonTapped), for: .touchUpInside)
        }
        
        
        return cell
    }
    
    @objc func commentMoreButtonTapped(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            let comment = self.post.comments[sender.tag]
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
            self.present(alert, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            let comment = self.post.comments[sender.tag]
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
                                self.showAlertOneButton(title: "댓글 신고", message: "해당 댓글이 신고되었습니다.", buttonTitle: "확인")
                            }
                        }
                        break
                    } else {
                        let alert = UIAlertController(title: "실패", message: "이미 신고한 댓글입니다.", preferredStyle: .alert)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == communityPageView.commentTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return updatedText.count <= 100
        }
        return true
    }
}

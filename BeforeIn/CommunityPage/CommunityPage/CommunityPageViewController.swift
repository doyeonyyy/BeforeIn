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
    
    // MARK: - Life Cycle
    override func loadView() {
        view = communityPageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        communityPageView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        communityPageView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func setTextField(){
        communityPageView.commentTextField.delegate = self
    }
    
    
    
    // MARK: - @objc
    @objc func editButtonTapped() {
        let post = post
        let modifyVC = ModifyViewController()
        modifyVC.post = post
        self.navigationController?.pushViewController(modifyVC, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: "삭제하시면 복구가 불가능합니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "예" , style: .destructive) { _ in
            self.db.collection("Post").document(self.post.postID).delete()
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "아니오", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
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
        let writer = currentUser.email
        let writerNickName = currentUser.nickname
        let content = comment
        let postingTime = Date()
        let newComment = Comment(writer: writer, writerNickName: writerNickName, content: content, postingTime: postingTime)
        self.post.comments.append(newComment)
        let commentsData: [[String: Any]] = self.post.comments.map { comment in
            return [
                "writer": comment.writer,
                "writerNickName": comment.writerNickName,
                "content": comment.content,
                "postingTime": comment.postingTime
            ]
        }

        db.collection("Post").document(self.post.postID).updateData(["comments": commentsData]) { error in
            if let error = error {
                print("Error updating comments in Firestore: \(error.localizedDescription)")
            } else {
                print("Comments updated successfully")
            }
        }
//        db.collection("Comment").addDocument(data: [
//            "writer": currentUser.email,
//            "writerNickName": currentUser.nickname,
//            "content": comment,
//            "postingTime": postingTime
//        ]) { error in
//            if let error = error {
//                print("Error adding comment: \(error.localizedDescription)")
//            } else {
//                print("Comment added successfully")
//            }
//        }
    }
    
    // 댓글 불러오기
    func loadComments() {
        
        db.collection("Comment")
            .order(by: "postingTime")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("댓글을 불러오는 중 오류 발생: \(error.localizedDescription)")
                } else {
                    var comments = [Comment]()
                    
                    if let documents = querySnapshot?.documents {
                        for document in documents {
                            let data = document.data()
                            if let writer = data["writer"] as? String,
                               let writerNickName = data["writerNickName"] as? String,
                               let content = data["content"] as? String,
                               let postingTime = data["postingTime"] as? Timestamp { // Firestore의 Timestamp 타입을 사용
                                let comment = Comment(writer: writer, writerNickName: writerNickName, content: content, postingTime: postingTime.dateValue())
                                comments.append(comment)
                            }
                        }
                        self.comments = comments
                        self.communityPageView.commentTableView.reloadData()
                        
                        if !comments.isEmpty {
                            let indexPath = IndexPath(row: self.comments.count - 1, section: 0)
                            self.communityPageView.commentTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        }
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
                print("변화 감지됨")
                let data = document.data() ?? [:]
                let category = data["category"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                let likes = data["likes"] as? Int ?? 0
                let postingTime = data["postingTime"] as? Timestamp ?? Timestamp(date: Date())
                let postingID = data["postingID"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let writer = data["writer"] as? String ?? ""
                let writerNickName = data["writerNickName"] as? String ?? ""
                
                var comments: [Comment] = []
                if let commentsData = data["comments"] as? [[String: Any]] {
                    for comment in commentsData {
                        if let commentWriter = comment["writer"] as? String,
                           let commentPostingTime = comment["postingTime"] as? Timestamp,
                           let commentContent = comment["content"] as? String,
                           let commentWriterNickName = comment["writerNickName"] as? String {
                            let newComment = Comment(writer: commentWriter, writerNickName: commentWriterNickName, content: commentContent, postingTime: commentPostingTime.dateValue())
                            comments.append(newComment)
                        }
                    }
                }
                
                let fetchedPost = Post(writer: writer, writerNickName: writerNickName, postID: postingID, title: title, content: content, comments: comments, likes: likes, category: category, postingTime: postingTime.dateValue())
                self.post = fetchedPost
                self.communityPageView.communityPageViewModel?.updatePost(fetchedPost)
                self.communityPageView.commentTableView.reloadData()
                print("패치완료")
            }
        }
    }

    
    
}



// MARK: - UITableViewDelegate
extension CommunityPageViewController: UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource
extension CommunityPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
//        return post.comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: post.comments[indexPath.row].postingTime)
        
        cell.dateLabel.text = dateString
        cell.commentLabel.text = post.comments[indexPath.row].content
        cell.authorLabel.text = post.comments[indexPath.row].writerNickName
        cell.editButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(commentEditButtonTapped), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(commentDeleteButtonTapped), for: .touchUpInside)
        
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
                            "postingTime": comment.postingTime
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
                            "postingTime": comment.postingTime
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

    
}

// MARK: - UITextFieldDelegate
extension CommunityPageViewController: UITextFieldDelegate {
    
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
}

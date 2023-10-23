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
    var comments = [Comment]()
    let db = Firestore.firestore()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = communityPageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        addTarget()
        loadComments()
    }
    
    
    // MARK: - Methods
    func setTableView(){
        communityPageView.commentTableView.delegate = self
        communityPageView.commentTableView.dataSource = self
        communityPageView.commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    }
    
    func addTarget(){
        communityPageView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: - @objc
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
        let postingTime = Date()
        db.collection("Comment").addDocument(data: [
            "writer": currentUser.email,
            "writerNickName": currentUser.nickname,
            "content": comment,
            "postingTime": postingTime
        ]) { error in
            if let error = error {
                print("Error adding comment: \(error.localizedDescription)")
            } else {
                print("Comment added successfully")
            }
        }
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


    
    
}



// MARK: - UITableViewDelegate
extension CommunityPageViewController: UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource
extension CommunityPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: comments[indexPath.row].postingTime)
        
        cell.dateLabel.text = dateString
        cell.commentLabel.text = comments[indexPath.row].content
        cell.authorLabel.text = comments[indexPath.row].writerNickName
        return cell
    }


    
}


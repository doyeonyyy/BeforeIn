//
//  CommunityPageViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/20.
//

import UIKit

class CommunityPageViewController: BaseViewController {
    
    // MARK: - Properties
    private let communityPageView = CommunityPageView()
    var comments = ["댓글이다아아ㅣ아", "댓글ㅋㅋ", "댓글이ㅏㄹ어랴ㅓㄴㅇ랴"]
    
    // MARK: - Life Cycle
    override func loadView() {
        view = communityPageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    
    // MARK: - Methods
    func setTableView(){
        communityPageView.commentTableView.delegate = self
        communityPageView.commentTableView.dataSource = self
        communityPageView.commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
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
        cell.commentLabel.text = comments[indexPath.row]
        
        return cell
    }
    
    
    
    
}


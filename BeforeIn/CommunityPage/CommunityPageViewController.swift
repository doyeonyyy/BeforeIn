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
    
    // MARK: - Life Cycle
    override func loadView() {
        view = communityPageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Methods
    func setTableView(){
        communityPageView.commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    }
    

  

}

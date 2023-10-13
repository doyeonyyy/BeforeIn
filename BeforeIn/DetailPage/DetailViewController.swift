//
//  DetailViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    private let detailView = DetailView()

    // MARK: - Life Cycle
    override func loadView(){
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    




    
}

//
//  PasswordEditViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/21.
//

import UIKit

class PasswordEditViewController: BaseViewController {

    // MARK: - Properties
    let passwordEditView = PasswordEditView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = passwordEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    



}

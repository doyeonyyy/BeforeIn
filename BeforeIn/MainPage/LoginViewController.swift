//
//  LoginViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // Properties
    private let loginView = LoginView()
    
    // Life Cycle
    override func loadView(){
        view = loginView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
}

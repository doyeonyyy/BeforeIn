//
//  TermsAndConditionsViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/31/23.
//

import UIKit
import SnapKit
import WebKit

class TermsAndConditionsViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Properties
    private let webView = WKWebView().then {
        $0.backgroundColor = .systemBackground
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        webView.navigationDelegate = self
   
        if let url = URL(string: "https://chalk-fir-f36.notion.site/e052b9126c154a2f8cee6e6428eefc46?pvs=4") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        configureUI()
    }
    
    // MARK: - Methods
    private func configureUI() {
        // addSubView
        view.addSubview(webView)
        
        // makeConstraints
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

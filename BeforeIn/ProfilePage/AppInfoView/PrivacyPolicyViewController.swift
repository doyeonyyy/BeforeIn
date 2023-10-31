//
//  PrivacyPolicyViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/31/23.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
   
        if let url = URL(string: "https://chalk-fir-f36.notion.site/0c87ef13ab9d45a28dfefe5bff44982d?pvs=4") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension PrivacyPolicyViewController: WKNavigationDelegate {

}

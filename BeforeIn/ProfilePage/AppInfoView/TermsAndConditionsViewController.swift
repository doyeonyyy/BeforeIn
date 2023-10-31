//
//  TermsAndConditionsViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/31/23.
//

import UIKit
import WebKit

class TermsAndConditionsViewController: UIViewController {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
   
        if let url = URL(string: "https://chalk-fir-f36.notion.site/e052b9126c154a2f8cee6e6428eefc46?pvs=4") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension TermsAndConditionsViewController: WKNavigationDelegate {

}

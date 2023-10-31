//
//  NoticeViewController.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/31/23.
//

import UIKit
import WebKit

class NoticeViewController: UIViewController {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
   
        if let url = URL(string: "https://chalk-fir-f36.notion.site/4693d7b6de8743fb9000e1e3be246c4e?pvs=4") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
extension NoticeViewController: WKNavigationDelegate {

}

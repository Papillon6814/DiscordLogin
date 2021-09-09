//
//  WebViewController.swift
//  DiscordLogin
//
//  Created by Papillon on 2021/09/09.
//

import Foundation
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://discord.com/api/oauth2/authorize?client_id=885399115763183656&redirect_uri=https%3A%2F%2Fe-players-web.web.app%2F&response_type=code&scope=email%20identify") else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // ここでcode取得できそう
        print(navigationAction.request.url)
        
        decisionHandler(.allow)
        
        if let url = navigationAction.request.url,
           let code = url.queryValue(for: "code") {
            print("code: \(code)")
        }
        //dismiss(animated: true)
    }
}

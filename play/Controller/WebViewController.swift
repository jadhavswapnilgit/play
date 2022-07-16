//
//  WebViewController.swift
//  play
//
//  Created by Sachin Jadhav on 16/07/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {

    
    var webView: WKWebView!
    
    var urls : String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        guard let urlE = urls else {
            return
        }

        let url = URL(string: urlE)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true        // Do any additional setup after loading the view.
    }
    

   
   

}

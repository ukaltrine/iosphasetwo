//
//  WebViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 4/14/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setupWebView()
    }
    
    
    func setupWebView(){
        
        loader.isHidden = false
        loader.startAnimating()
        
        let url = URL(string: "https://www.instagram.com/ukaltrine/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        loader.isHidden = true
        loader.stopAnimating()
        
    }
    

}

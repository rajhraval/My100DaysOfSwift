//
//  WebViewController.swift
//  Project16
//
//  Created by RAJ RAVAL on 20/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webview: WKWebView!
    var city: String!
    
    override func loadView() {
        webview = WKWebView()
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let city = city else { return }
        
        let url = URL(string: "https://en.wikipedia.org/wiki/\(city)")
        webview.load(URLRequest(url: url!))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

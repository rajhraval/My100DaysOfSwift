//
//  DetailViewController.swift
//  Project7
//
//  Created by RAJ RAVAL on 24/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, intial-scale=1">
        <style> h1,h3,p {font-family: -apple-system;}
        p {font-size: 22px;}
        </style>
        </head>
        <body>
            <h1>
            \(detailItem.title)
            </h1>
            <h3>
        Signatures: \(detailItem.signatureCount)
            </h3>
            <p>
            \(detailItem.body)
            </p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

}

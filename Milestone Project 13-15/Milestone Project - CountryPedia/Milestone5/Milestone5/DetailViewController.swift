//
//  DetailViewController.swift
//  Milestone5
//
//  Created by RAJ RAVAL on 18/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var countryItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let countryItem = countryItem else { return }
        
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, intial-scale=1">
        </head>
        <style> h1,h3,h5,p {font-family: -apple-system;}
        p {font-size: 22px;}
        </style>
        <body>
            <h1>\(countryItem.name)</h1>
            <h3>Capital: \(countryItem.capital)</h3>
            <h5>Area: \(countryItem.size)</h5>
            <h5>Population: \(countryItem.population)</h5>
            <h5>Currency: \(countryItem.currency)</h5>
            <p>Fact:\(countryItem.fact)</p>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    


}

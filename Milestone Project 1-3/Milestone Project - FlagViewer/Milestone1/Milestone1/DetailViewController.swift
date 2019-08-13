//
//  DetailViewController.swift
//  Milestone1
//
//  Created by RAJ RAVAL on 13/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage?.replacingOccurrences(of: "@3x.png", with: "").uppercased()
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.gray.cgColor
        }
        
        
    }
    
    @objc func shareFlag() {
        guard let imageToShare = imageView.image?.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let vc = UIActivityViewController(activityItems: ["I want to share this flag from Flag Viewer App",imageToShare], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated: true)
    }
    

}

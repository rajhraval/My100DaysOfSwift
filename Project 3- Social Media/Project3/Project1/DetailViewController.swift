//
//  DetailViewController.swift
//  Project1
//
//  Created by RAJ RAVAL on 07/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(selectedImageCount) of 10"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No images found")
            return
        }
        
        //let sharingImage = "Here is the Image \(selectedImage!) I would love to share it to you."
        
        let vc = UIActivityViewController(activityItems: ["Here is the Image \(selectedImage!) I would love to share it to you.",image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

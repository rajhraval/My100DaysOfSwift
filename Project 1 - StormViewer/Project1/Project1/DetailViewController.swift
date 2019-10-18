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

        assert(selectedImage != nil, "Image is nil!")
        title = "Picture \(selectedImageCount) of 10"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            let storm = UIImage(named: imageToLoad)
            
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: storm!.size.width, height: storm!.size.height))
            
            let image = renderer.image { ctx in

                storm?.draw(at: CGPoint(x: 0, y: 0))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                
                let attrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 36),
                    .paragraphStyle: paragraphStyle
                ]
                
                let string = "From Storm Viewer"
                
                let attributedString = NSAttributedString(string: string, attributes: attrs)
                
                attributedString.draw(with: CGRect(x: 0, y: 100, width: storm!.size.width, height: storm!.size.height - 100), options: .usesLineFragmentOrigin, context: nil)

                
            }
            imageView.image = image
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

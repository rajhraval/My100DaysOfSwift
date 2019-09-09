//
//  Image.swift
//  Milestone4
//
//  Created by RAJ RAVAL on 09/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class Image: NSObject, Codable {
    
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
    
}

//
//  Person.swift
//  Project10
//
//  Created by RAJ RAVAL on 02/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name:String, image: String) {
        self.name = name
        self.image = image
    }
}

//
//  Note.swift
//  Milestone7
//
//  Created by RAJ RAVAL on 03/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class Note: NSObject {
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}

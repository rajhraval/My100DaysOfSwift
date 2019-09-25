//
//  Target.swift
//  Milestone6
//
//  Created by RAJ RAVAL on 25/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import SpriteKit

class Target: SKNode {
    
    var boardTarget: SKSpriteNode!
    var stickTarget: SKSpriteNode!
    var isHit = false
    
    func configure() {
        
        let boardNumber = Int.random(in: 0...3)
        let stickNumber = Int.random(in: 0...2)
        
        boardTarget = SKSpriteNode(imageNamed: "boardTarget\(boardNumber)")
        stickTarget = SKSpriteNode(imageNamed: "stickTarget\(stickNumber)")
        
    }

}

//
//  GameScene.swift
//  Milestone6
//
//  Created by RAJ RAVAL on 25/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bulletsTierOne: SKSpriteNode!
    var bulletsTierTwo: SKSpriteNode!
    var cursor: SKSpriteNode!
    
    var bulletTexture = [
        SKTexture(imageNamed: "shots0"),
        SKTexture(imageNamed: "shots1"),
        SKTexture(imageNamed: "shots2"),
        SKTexture(imageNamed: "shots3")
    ]
    
    var showBullet = 3 {
        didSet {
            bulletsTierOne.texture = bulletTexture[showBullet]
            bulletsTierTwo.texture = bulletTexture[showBullet]
        }
    }
    
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var timerCount = 60 {
        didSet {
            timerLabel.text = "Time Left: \(timerCount)s"
        }
    }
    
    var gameTimer: Timer?
    
    override func didMove(to view: SKView) {
        
        let water = SKSpriteNode(imageNamed: "water-fg")
        water.position = CGPoint(x: 512, y: 450)
        water.size = CGSize(width: 1024, height: 350)
        water.zPosition = -2
        addChild(water)
        
        let waterInBackground = SKSpriteNode(imageNamed: "water-bg")
        waterInBackground.position = CGPoint(x: 512, y: 275)
        waterInBackground.size = CGSize(width: 1024, height: 300)
        waterInBackground.zPosition = -1
        addChild(waterInBackground)
        
        let waterInForeground = SKSpriteNode(imageNamed: "water-fg")
        waterInForeground.position = CGPoint(x: 512, y: 75)
        waterInForeground.size = CGSize(width: 1024, height: 300)
        waterInForeground.zPosition = 1
        addChild(waterInForeground)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: 1000, y: 710)
        scoreLabel.horizontalAlignmentMode = .right
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel.text = "Time Left: 60s"
        timerLabel.position = CGPoint(x: 512, y: 710)
        addChild(timerLabel)
        
        bulletsTierOne = SKSpriteNode(texture: bulletTexture[showBullet])
        bulletsTierOne.position = CGPoint(x: 100, y: 700)
        bulletsTierOne.zPosition = -1
        addChild(bulletsTierOne)
        
        bulletsTierTwo = SKSpriteNode(texture: bulletTexture[showBullet])
        bulletsTierTwo.position = CGPoint(x: 180, y: 700)
        bulletsTierTwo.zPosition = -1
        addChild(bulletsTierTwo)
        
        cursor = SKSpriteNode(imageNamed: "cursor")
        cursor.position = CGPoint(x: 512, y: 384)
        addChild(cursor)
        
        
        startTimer()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func startTimer() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reduceTime), userInfo: nil, repeats: true)
    }
    
    @objc func reduceTime() {
        timerCount -= 1
        if timerCount == 0 {
            gameTimer?.invalidate()
            let gameOver = SKSpriteNode(imageNamed: "game-over")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        cursor.position = touch.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        cursor.position = touch.location(in: self)
    
    }
    
}

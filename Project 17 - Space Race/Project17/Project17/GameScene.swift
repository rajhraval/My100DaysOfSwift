//
//  GameScene.swift
//  Project17
//
//  Created by RAJ RAVAL on 20/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var finalScore = 0
    var enemyCounter = 0
    var enemyTime = 1.0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        starfield.zPosition = -1
        addChild(starfield)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    
        startGame()
    }
    
    func startGame() {
        enemyTime = 1.0
        enemyCounter = 1
        isGameOver = false
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0
        
        startTimer()
    }
    
    func startTimer() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: enemyTime, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    func gameOver() {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        finalScore = score
        
        player.removeFromParent()
        isGameOver = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in
            guard let children = self?.children else { return }
            for node in children {
                node.removeFromParent()
            }
        }
    }
    
    @objc func createEnemy() {
        guard !isGameOver else { return }
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        addChild(sprite)
        enemyCounter += 1
        
        if enemyCounter.isMultiple(of: 20) {
            enemyTime -= 0.1
            startTimer()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameOver()
        alertUser(title: "You Cheated!", message: "You need to startover")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        gameOver()
        alertUser(title: "Game Over!", message: "Final Score is \(finalScore)")
    }
    
    func alertUser(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Restart Game", style: .default) {
            [weak self] _ in
            self?.startGame()
        })
        self.view?.window?.rootViewController?.present(ac, animated: true)
    }
    
}

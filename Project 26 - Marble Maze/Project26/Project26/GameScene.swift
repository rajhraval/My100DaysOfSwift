//
//  GameScene.swift
//  Project26
//
//  Created by RAJ RAVAL on 14/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

import CoreMotion
import SpriteKit

enum CollisionType: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var motionManager: CMMotionManager?
    var lastTouchPosition: CGPoint?
    let accelerationMultiplier: Double = 25.0
    var currentLevel = 1
    let maxLevel = 3
    var isTeleporting = false

    var levelNodes = [SKSpriteNode]()
    
    var isGameOver = false
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        
        createBackground()
        createScoreLabel()
        loadLevel()
        createPlayer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
    }
    
    func loadLevel() {
        let levelString = stringForLevel()
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                switch letter {
                case "x":
                    createWall(at: position)
                case "v":
                    createVortex(at: position)
                case "s":
                    createStar(at: position)
                case "f":
                    createFinish(at: position)
                case "1": // Teleport Point 1
                    createTeleport(at: position, isFirst: true)
                case "2": // Teleport Point 2
                    createTeleport(at: position, isFirst: false)
                case " ":
                    break
                default:
                    fatalError("Unknown level letter '\(letter)' in row \(row), column \(column)")
                }
            }
        }
    }
    
    func stringForLevel() -> String {
        guard let levelURL = Bundle.main.url(forResource: "level\(currentLevel)", withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level1.txt from the app bundle.")
        }
        return levelString.trimmingCharacters(in: .newlines)
    }
    
    func createWall(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionType.wall.rawValue
        node.physicsBody?.isDynamic = false
        addChild(node)
        levelNodes.append(node)
    }
    
    func createVortex(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionType.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        levelNodes.append(node)
    }
    
    func createStar(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.position = position
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionType.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        levelNodes.append(node)
    }
    
    func createFinish(at position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.position = position
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionType.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        levelNodes.append(node)
    }
    
    func createTeleport(at position: CGPoint, isFirst: Bool) {
        let node = SKSpriteNode(imageNamed: "teleport")
        
        if isFirst {
            node.name = "teleport1"
        } else {
            node.name = "teleport2"
        }
        node.position = position
        
        let scaleDown = SKAction.scale(to: 0.7, duration: 0.3)
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.3)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        node.run(SKAction.repeatForever(sequence))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionType.teleport.rawValue
        node.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        levelNodes.append(node)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.star.rawValue | CollisionType.vortex.rawValue | CollisionType.finish.rawValue | CollisionType.teleport.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.wall.rawValue
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           guard let touch = touches.first else { return }
           let location = touch.location(in: self)
           lastTouchPosition = location
       }
       
       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           guard let touch = touches.first else { return }
           let location = touch.location(in: self)
           lastTouchPosition = location
       }
       
       override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           lastTouchPosition = nil
       }
    
    override func update(_ currentTime: TimeInterval) {
        guard !isGameOver else { return }
        
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        
        switch node.name {
            
        case "vortex":
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
            
        case "star":
            node.removeFromParent()
            score += 1
            
        case "finish":
            player.removeFromParent()
            
            levelNodes.forEach { $0.removeFromParent() }
            levelNodes.removeAll()
            if currentLevel == maxLevel {
                currentLevel = 1
            } else {
                currentLevel += 1
            }

            loadLevel()
            createPlayer()
            
        
        case "teleport1":
            guard !isTeleporting else { break }
            if let teleport2 = self.childNode(withName: "teleport2") {
                teleportPlayer(from: node.position, to: teleport2.position)
            }
        case "teleport2":
            guard !isTeleporting else { break }
            isTeleporting = true
            if let teleport1 = self.childNode(withName: "teleport1") {
                teleportPlayer(from: node.position, to: teleport1.position)
            }
        
        default:
            break
        }
    }
    
    func teleportPlayer(from oldPosition: CGPoint, to newPosition: CGPoint) {
        
        // Change state to show teleport in progress
        isTeleporting = true
        
        // Temporarily disable physics on player
        player.physicsBody?.isDynamic = false
    
        let moveToMiddle = SKAction.move(to: oldPosition, duration: 0.25)
        let scaleOut = SKAction.scale(to: 0.0001, duration: 0.25)
        let moveToNewPosition = SKAction.move(to: newPosition, duration: 0)
        let scaleIn = SKAction.scale(to: 1, duration: 0.25)
        
        let restorePhysicsBody = SKAction.run { [weak self] in
            self?.player.physicsBody?.isDynamic = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isTeleporting = false
        }
        
        player.run(SKAction.sequence([moveToMiddle, scaleOut, moveToNewPosition, scaleIn, restorePhysicsBody]))
    }
}

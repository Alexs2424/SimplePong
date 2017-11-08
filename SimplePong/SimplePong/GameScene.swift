//
//  GameScene.swift
//  SimplePong
//
//  Created by Alex Santarelli on 10/31/17.
//  Copyright © 2017 Alex Santarelli. All rights reserved.
//

import SpriteKit
import GameplayKit

private let PLAYER_CATEGORY: UInt32 = 0x1 << 0
private let BALL_CATEGORY:UInt32 = 0x1 << 1
private let CPU_CATEGORY:UInt32 = 0x1 << 2
private let WALL_CATEGORY:UInt32 = 0x1 << 3

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Label nodes
    var titleLabel:SKLabelNode?
    var scoreLabel:SKLabelNode?
    
    //Game nodes
    var player:SKSpriteNode?
    var ball:SKSpriteNode?
    var cpu:SKSpriteNode?
    
    //Buttons
    var up:SKSpriteNode?
    var down:SKSpriteNode?
    
    //Game variables
    var score = 0
    var isTouchingUp = false
    var isTouchingDown = false
    
    override func didMove(to view: SKView) {
        setupGame()
        setupPhysics()
    }
    
    func setupGame() {
        //Essential View Setup
        self.view?.backgroundColor = .black
        
        /* LABEL SETUP */
        //Title Label
        titleLabel = SKLabelNode(fontNamed: "AvenirNext-Medium")
        titleLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 47.0)
        titleLabel?.fontSize = 40.0
        titleLabel?.color = .white
        titleLabel?.text = "Play Pong!"
        self.addChild(titleLabel!)
        
        //Score Label
        scoreLabel = SKLabelNode(fontNamed: "AvenirNext-UltraLight") //Was Helvetica-Light
        scoreLabel?.position = CGPoint(x: self.frame.minX + 32.0, y: self.frame.maxY - 50.0)
        scoreLabel?.fontSize = 45.0
        scoreLabel?.color = .white
        scoreLabel?.text = "\(score)"
        self.addChild(scoreLabel!)
        /* END LABEL SETUP */
        
        /* GAME SPRITE SETUP */
        //Player Sprite
        player = SKSpriteNode(color: .white, size: CGSize(width: 10.0, height: 80.0)) //w 8 h 30
        player?.position = CGPoint(x: 110.0, y: 100.0)
        self.addChild(player!)
        
        //Ball Sprite
        //need to create an image for this sprite to be created
        ball = SKSpriteNode(imageNamed: "Ball")
        ball?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(ball!)
        
        //CPU Sprite
        cpu = SKSpriteNode(color: .white, size: CGSize(width: 10.0, height: 80.0))
        cpu?.position = CGPoint(x: self.frame.maxX - 80.0, y: 100.0)
        self.addChild(cpu!)
        /* END GAME SPRITE SETUP */
        
        /* BUTTON AND CONTROL SETUP */
        up = SKSpriteNode(imageNamed: "Up")
        up?.position = CGPoint(x: self.frame.minX + 40.0, y: self.frame.minY + 108.0)
        up?.size = CGSize(width: 50.0, height: 50.0)
        self.addChild(up!)
        
        down = SKSpriteNode(imageNamed: "Down")
        down?.position = CGPoint(x: self.frame.minX + 40.0, y: self.frame.minY + 40.0)
        down?.size = CGSize(width: 50.0, height: 50.0)
        self.addChild(down!)
        /* END BUTTON CONTROL SETUP */
        
    }
    
    func setupPhysics() {
        //Setting the delegate
        self.physicsWorld.contactDelegate = self
        
        //Creating the borderbody so the ball can bounce off of the walls.
       // let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0.0
        self.physicsBody?.categoryBitMask = WALL_CATEGORY
        self.physicsBody?.collisionBitMask = BALL_CATEGORY | PLAYER_CATEGORY | CPU_CATEGORY
        self.physicsBody?.contactTestBitMask = 0
        
        //Configuring the gravity in the world.
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        //Configuring Player One Node Physics
        self.player?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.player?.physicsBody = SKPhysicsBody(rectangleOf: (player?.frame.size)!)
        self.player?.physicsBody?.categoryBitMask = PLAYER_CATEGORY
        self.player?.physicsBody?.collisionBitMask = WALL_CATEGORY | BALL_CATEGORY //| CPU_CATEGORY
        self.player?.physicsBody?.contactTestBitMask = 0 //might need to be changed to account for the ball.
        self.player?.physicsBody?.mass = 100.0
        self.player?.physicsBody?.restitution = 0.0
        self.player?.physicsBody?.linearDamping = 0.0
        self.player?.physicsBody?.allowsRotation = false
        
        
        //Configuring Ball Node Physics
        self.ball?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.ball?.physicsBody = SKPhysicsBody(circleOfRadius: (self.player?.frame.size.height)! / 6) //was 4
        self.ball?.physicsBody?.categoryBitMask = BALL_CATEGORY
        self.ball?.physicsBody?.collisionBitMask = WALL_CATEGORY | PLAYER_CATEGORY | CPU_CATEGORY
        self.ball?.physicsBody?.contactTestBitMask = 0 //may change depending on points system setup
        self.ball?.physicsBody?.mass = 5.0
        self.ball?.physicsBody?.restitution = 1.0
        self.ball?.physicsBody?.linearDamping = 0.0 //was 1.0
        self.ball?.physicsBody?.allowsRotation = false
        
        
        //Configuring Cpu Node Physics
        self.cpu?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.cpu?.physicsBody = SKPhysicsBody(rectangleOf: (cpu?.frame.size)!)
        self.cpu?.physicsBody?.categoryBitMask = CPU_CATEGORY
        self.cpu?.physicsBody?.collisionBitMask = WALL_CATEGORY | BALL_CATEGORY //| CPU_CATEGORY
        self.cpu?.physicsBody?.contactTestBitMask = 0 //might need to be changed to account for the ball.
        self.cpu?.physicsBody?.mass = 100.0
        self.cpu?.physicsBody?.restitution = 0.0
        self.cpu?.physicsBody?.linearDamping = 0.0
        self.cpu?.physicsBody?.allowsRotation = false
//        self.cpu?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.cpu?.physicsBody = SKPhysicsBody(rectangleOf: (cpu?.frame.size)!)
//        self.cpu?.physicsBody?.categoryBitMask = CPU_CATEGORY
//        self.cpu?.physicsBody?.collisionBitMask = WALL_CATEGORY | BALL_CATEGORY
//        self.cpu?.physicsBody?.contactTestBitMask = 0
//        self.cpu?.physicsBody?.mass = 100.0
//        self.cpu?.physicsBody?.restitution = 0.0
//        self.cpu?.physicsBody?.linearDamping = 0.0
//        self.cpu?.physicsBody?.allowsRotation = false
        
        //Setting the intial verlocoty of the ball
        self.ball?.physicsBody?.velocity = CGVector(dx: 150.0, dy: 150.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location:CGPoint = t.location(in: self)
            
            //Checking to see if the up button was pressed
            if self.up!.contains(location) {
                self.isTouchingUp = true
                self.isTouchingDown = false
            } else if self.down!.contains(location) {
                self.isTouchingDown = true
                self.isTouchingUp = false
            }
        
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location:CGPoint = t.location(in: self)
            
            //Checking to see if the up button was pressed
            if self.up!.contains(location) {
                self.isTouchingUp = true
                self.isTouchingDown = false
            } else if self.down!.contains(location) {
                self.isTouchingDown = true
                self.isTouchingUp = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location:CGPoint = t.location(in: self)
            
            //Checking to see if the up button was pressed
            if self.up!.contains(location) {
                self.isTouchingUp = false
                self.isTouchingDown = false
                self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            } else if self.down!.contains(location) {
                self.isTouchingDown = false
                self.isTouchingUp = false
                self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location:CGPoint = t.location(in: self)
            
            //Checking to see if the up button was pressed
            if self.up!.contains(location) {
                self.isTouchingUp = false
                self.isTouchingDown = false
                self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            } else if self.down!.contains(location) {
                self.isTouchingDown = false
                self.isTouchingUp = false
                self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        checkForScore()
        
        if self.isTouchingUp {
            self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 200.0)
//            self.isTouchingUp = false
        } else if self.isTouchingDown {
            self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: -200.0)
//            self.isTouchingDown = false
        } else {
            self.player?.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    func incrementScore() {
        self.score += 1
        self.scoreLabel?.text = "\(self.score)"
    }
    
    func checkForScore() {

        if (self.ball!.position.x < self.player!.position.x) {
            //cpu scored on player one
            print("CPU Scored! You Lost. Game Over.")
        } else if (self.ball!.position.x > self.cpu!.position.x) {
            //player scored on cpu
            incrementScore()
            print("Player Scored! You Won. Game Over.")
        }
    }
}

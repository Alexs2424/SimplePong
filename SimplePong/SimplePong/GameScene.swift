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
    
    //Buttons
    var up:SKSpriteNode?
    var down:SKSpriteNode?
    
    //Game variables
    var score = 0
    
    override func didMove(to view: SKView) {
        setupGame()
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

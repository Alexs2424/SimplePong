//
//  GameViewController.swift
//  SimplePong
//
//  Created by Alex Santarelli on 10/31/17.
//  Copyright © 2017 Alex Santarelli. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let scene = SKScene(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    

//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            //changed to false used to be true
//            view.ignoresSiblingOrder = false
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

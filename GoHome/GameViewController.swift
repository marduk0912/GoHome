//
//  GameViewController.swift
//  GoHome
//
//  Created by Fernando on 02/04/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: CGSize(width: 2400, height: 1502))
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

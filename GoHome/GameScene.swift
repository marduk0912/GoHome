//
//  GameScene.swift
//  GoHome
//
//  Created by Fernando on 02/04/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMujer), SKAction.run(addHombre), SKAction.wait(forDuration: 0.5)
            ])))
        
       
        }
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 294967296)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }

    func addMujer() {
      
      // Create sprite
      let mujer1 = SKTexture(imageNamed: "mujer")
      mujer1.filteringMode = SKTextureFilteringMode.nearest
      let mujer2 = SKTexture(imageNamed: "mujer1")
      mujer2.filteringMode = SKTextureFilteringMode.nearest
        
      let animacionMujer = SKAction.animate(with: [mujer1, mujer2], timePerFrame: 0.2)
      let mujerCaminando = SKAction.repeatForever(animacionMujer)
        
      let mujer = SKSpriteNode(texture: mujer1)
      mujer.run(mujerCaminando)
      
      // Determine where to spawn the mujer along the Y axis
      let actualY = random(min: mujer.size.height/2, max: size.height - mujer.size.height/2)
      
      // Position the monster slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
      mujer.position = CGPoint(x: size.width + mujer.size.width/2, y: actualY)
      
      // Add the monster to the scene
      addChild(mujer)
      
      // Determine speed of the monster
      let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.5))
      
      // Create the actions
      let actionMove = SKAction.move(to: CGPoint(x: -mujer.size.width/2, y: actualY),
                                     duration: TimeInterval(actualDuration))
      let actionMoveDone = SKAction.removeFromParent()
      mujer.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addHombre() {
      
      // Create sprite
      let hombre1 = SKTexture(imageNamed: "hombre")
      hombre1.filteringMode = SKTextureFilteringMode.nearest
      let hombre2 = SKTexture(imageNamed: "hombre1")
      hombre2.filteringMode = SKTextureFilteringMode.nearest
        
      let animacionHombre = SKAction.animate(with: [hombre1, hombre2], timePerFrame: 0.2)
      let hombreCaminando = SKAction.repeatForever(animacionHombre)
        
      let hombre = SKSpriteNode(texture: hombre1)
      hombre.run(hombreCaminando)
      
      // Determine where to spawn the monster along the Y axis
      let actualY = random(min: hombre.size.height/2, max: size.height - hombre.size.height/2)
      
      // Position the monster slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
      hombre.position = CGPoint(x: size.width + hombre.size.width/2, y: actualY)
      
      // Add the monster to the scene
      addChild(hombre)
      
      // Determine speed of the monster
      let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.5))
      
      // Create the actions
      let actionMove = SKAction.move(to: CGPoint(x: -hombre.size.width/2, y: actualY),
                                     duration: TimeInterval(actualDuration))
      let actionMoveDone = SKAction.removeFromParent()
      hombre.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
        
  
}

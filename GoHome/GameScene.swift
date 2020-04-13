//
//  GameScene.swift
//  GoHome
//
//  Created by Fernando on 02/04/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
    let policia = SKSpriteNode(imageNamed: "Policia")
    
    var lastUpdatedTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    let policiaPixelPerSecond: CGFloat = 200.0
    var velocityPolicia = CGPoint.zero
    
    
    override func didMove(to view: SKView) {
        
        let backgraund = SKSpriteNode(imageNamed: "Image42")
        backgraund.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgraund.zPosition = -1
        backgraund.size.width = self.size.width
        backgraund.size.height = self.size.height
        addChild(backgraund)
        
        policia.position = CGPoint(x: 25, y: 30)
        policia.yScale = 0.75
        policia.xScale = 0.75
        addChild(policia)
       
        run(SKAction.repeat(SKAction.sequence([SKAction.run(addMujer), SKAction.run(addHombre), SKAction.sequence([SKAction.run(addCorona)]), SKAction.wait(forDuration: 0.5)]), count: 1))
        
        }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdatedTime > 0 {
            dt = currentTime - lastUpdatedTime
        }else{
            dt = 0
        }
        lastUpdatedTime = currentTime
        
        moveSprite(sprite: policia, velocity: velocityPolicia)
        checkBounds()
        rotateSprite(sprite: policia, direction: velocityPolicia)
    }
    
    func moveSprite(sprite:SKSpriteNode, velocity:CGPoint){
        
        // Espacio es igual a Velocidad por Tiempo
        let cantidad = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        sprite.position = CGPoint(x: sprite.position.x + cantidad.x, y: sprite.position.y + cantidad.y)
    }
    
    func policiaToLocation(location: CGPoint) {
        
        //  Cantidad de movimiento que debemos darle al policia para llegar donde hemos tocado
        let offset = CGPoint(x: location.x - policia.position.x, y: location.y - policia.position.y)
        let longitudOffset = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        
        // Vector unitario de movimiento
        let direccion = CGPoint(x: offset.x / CGFloat(longitudOffset), y: offset.y / CGFloat(longitudOffset))
        velocityPolicia = CGPoint(x: direccion.x * policiaPixelPerSecond, y: direccion.y * policiaPixelPerSecond)
    }
    
    func sceneTouched(touchLocation: CGPoint){
        
        policiaToLocation(location: touchLocation)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        sceneTouched(touchLocation: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        sceneTouched(touchLocation: location)
        
    }
    
    func checkBounds (){
        let bottomLeft = CGPoint.zero
        let uperRight = CGPoint(x: size.width, y: size.height)
        
        if policia.position.x <= bottomLeft.x {
            policia.position.x = bottomLeft.x
            velocityPolicia.x = -velocityPolicia.x
        }
        if policia.position.x >= uperRight.x {
            policia.position.x = uperRight.x
            velocityPolicia.x = -velocityPolicia.x
        
        }
        if policia.position.y <= bottomLeft.y {
            policia.position.y = bottomLeft.y
            velocityPolicia.y = -velocityPolicia.y
        }
        if policia.position.y >= uperRight.y {
            policia.position.y = uperRight.y
            velocityPolicia.y = -velocityPolicia.y
        }
    }
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint) {
        sprite.zRotation = CGFloat(atan2(Double(direction.y), Double(direction.x)))
    }
    
  
    
   func random() -> CGFloat {
        return CGFloat(drand48() / 375)
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
       
     let animacionMujer = SKAction.animate(with: [mujer1, mujer2], timePerFrame: 0.1)
     let mujerCaminando = SKAction.repeatForever(animacionMujer)
       
     let mujer = SKSpriteNode(texture: mujer1)
     mujer.run(mujerCaminando)
     
     // Determine where to spawn the mujer along the Y axis
      
    let actualY = view?.bounds.height
     
     // Position the mujer slightly off-screen along the right edge,
     // and along a random position along the Y axis as calculated above
    mujer.position = CGPoint(x: size.width / 2, y: actualY! / 4)
    
    mujer.yScale = 0.75
    mujer.xScale = 0.75
    
     // Add the mujer to the scene
     addChild(mujer)
     
     // Create the actions
    
     let path = CGMutablePath()
     path.move(to: CGPoint(x: 0, y: 0))
     path.addLine(to: CGPoint(x: -250, y: 10))
     let followLine = SKAction.follow(path, asOffset: true, orientToPath: false, speed: 50)
     let reversed = followLine.reversed()
     
     
    
    
    
    
//    let actionMove = SKAction.move(to: CGPoint(x: -mujer.size.width/2, y: actualY!), duration: TimeInterval(actualDuration))
 //    let actionMoveDone = SKAction.removeFromParent()
    mujer.run(SKAction.repeatForever(SKAction.sequence([followLine, reversed])))
    
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
     
     // Determine where to spawn the hombre along the Y axis
    let actualY = view?.bounds.height
     
     // Position the hombre slightly off-screen along the right edge,
     // and along a random position along the Y axis as calculated above
     hombre.position = CGPoint(x: size.width + hombre.size.width/2, y: actualY! / 4)
   
     hombre.yScale = 0.75
     hombre.xScale = 0.75
     
    // Add the hombre to the scene
     addChild(hombre)
     
   
     
     // Create the actions
     let path = CGMutablePath()
     path.move(to: CGPoint(x: 0, y: 0))
     path.addLine(to: CGPoint(x: -250, y: 5))
     let followLine = SKAction.follow(path, asOffset: true, orientToPath: false, speed: 50)
     let reversed = followLine.reversed()
    hombre.run(SKAction.repeatForever(SKAction.sequence([followLine, reversed])))
   }


   func addCorona() {
        
        // Create sprite
        let corona1 = SKTexture(imageNamed: "corona")
        corona1.filteringMode = SKTextureFilteringMode.nearest
        let corona2 = SKTexture(imageNamed: "corona1")
        corona2.filteringMode = SKTextureFilteringMode.nearest
        let corona3 = SKTexture(imageNamed: "corona2")
        corona3.filteringMode = SKTextureFilteringMode.nearest
        let corona4 = SKTexture(imageNamed: "corona3")
        corona4.filteringMode = SKTextureFilteringMode.nearest
          
        let animacionCorona = SKAction.animate(with: [corona1, corona2, corona3, corona4], timePerFrame: 0.2)
        let coronaGirando = SKAction.repeatForever(animacionCorona)
          
        let corona = SKSpriteNode(texture: corona1)
        corona.run(coronaGirando)
        
        // Determine where to spawn the corona along the Y axis
        let actualY = random(min: (self.view?.bounds.minY)! , max: (self.view?.bounds.maxY)!)
        print("la posicion es \(actualY)")
        print("min y \(String(describing: self.view?.bounds.minY))")
        print("min y \(String(describing: self.view?.bounds.maxY))")
        
        // Position the corona slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        corona.position = CGPoint(x: size.width + corona.size.width/2, y: actualY)
  
        // Add the corona to the scene
        addChild(corona)
        
        // Determine speed of the corona
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.5))
        
        // Create the actions
    
    
       
    
        let actionMove = SKAction.move(to: CGPoint(x: -corona.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        corona.run(SKAction.sequence([actionMove, actionMoveDone]))
      }

   /*
          
          // 1
           let corona1 = SKTexture(imageNamed: "corona")
           corona1.filteringMode = SKTextureFilteringMode.nearest
           let corona2 = SKTexture(imageNamed: "corona1")
           corona2.filteringMode = SKTextureFilteringMode.nearest
           let corona3 = SKTexture(imageNamed: "corona2")
           corona3.filteringMode = SKTextureFilteringMode.nearest
           let corona4 = SKTexture(imageNamed: "corona3")
           corona4.filteringMode = SKTextureFilteringMode.nearest
                    
           let animacionCorona = SKAction.animate(with: [corona1, corona2, corona3, corona4], timePerFrame: 0.2)
           let coronaGirando = SKAction.repeatForever(animacionCorona)
                    
           let corona = SKSpriteNode(texture: corona1)
           corona.run(coronaGirando)
          
           corona.position = CGPoint(x: 0, y: 0)
           addChild(corona)
          
          // 2
          let path = CGMutablePath()
          path.move(to: CGPoint(x: 0, y: 0))
          path.addLine(to: CGPoint(x: 250, y: 250))
          let followLine = SKAction.follow(path, speed: 20.0)
              
          // 3
          let reversedLine = followLine.reversed()
              
          // 4
          let square = UIBezierPath(rect: CGRect(x: random(),y: random(), width: 150, height: 150))
          let followSquare = SKAction.follow(square.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
              
          // 5
          let circle = UIBezierPath(roundedRect: CGRect(x: random(), y: random(), width: 150, height: 150), cornerRadius: 500)
          let followCircle = SKAction.follow(circle.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
              
          // 6
          corona.run(SKAction.repeatForever(SKAction.sequence([followLine,reversedLine,followSquare,followCircle])))
   
   
          */

    
  
}

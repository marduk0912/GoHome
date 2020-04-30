//
//  GameScene.swift
//  GoHome
//
//  Created by Fernando on 02/04/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit
import Foundation



class GameScene: SKScene {
    
    let policiaUno = SKTexture(imageNamed: "PoliciaDer")
    let policiaDos = SKTexture(imageNamed: "PoliciaDer1")

    var policia = SKSpriteNode()
    var policiaCaminandoDer = SKAction()

    
    
    
    var lastUpdatedTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    let policiaPixelPerSecond: CGFloat = 200.0
    let policiaAnglePerSecond: CGFloat = 1.0 * π
    var velocityPolicia = CGPoint.zero
    var lastTouchLocation = CGPoint.zero
    
    let playableArea: CGRect = CGRect()
    
    
    override func didMove(to view: SKView) {
        
        let backgraund = SKSpriteNode(imageNamed: "Image42")
        backgraund.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgraund.zPosition = -1
        backgraund.size.width = self.size.width
        backgraund.size.height = self.size.height
        addChild(backgraund)
        
        
        let animacionPoliciaDerecha = SKAction.animate(with: [policiaUno, policiaDos], timePerFrame: 0.1)
        policiaCaminandoDer = SKAction.repeatForever(animacionPoliciaDerecha)
        policia = SKSpriteNode(texture: policiaUno)
        policia.position = CGPoint(x: 25, y: 30)
        policia.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        policia.yScale = 0.75
        policia.xScale = 0.75
        
        addChild(policia)
        addCorona()
       
        run(SKAction.repeat(SKAction.sequence([SKAction.run(addMujer), SKAction.run(addHombre), SKAction.wait(forDuration: 0.5)]), count: 1))
        
        }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        if lastUpdatedTime > 0 {
            dt = currentTime - lastUpdatedTime
        }else{
            dt = 0
        }
        lastUpdatedTime = currentTime
        
        checkBounds()
        
       if (policia.position - lastTouchLocation).longitud() < policiaPixelPerSecond * CGFloat(dt) {
           velocityPolicia = CGPoint.zero
           policia.removeAllActions()
       }else {
            moveSprite(sprite: policia, velocity: velocityPolicia)
            //rotateSprite(sprite: policia, direction: velocityPolicia)
           
       }
        
      
    }
    
    func moveSprite(sprite:SKSpriteNode, velocity:CGPoint){
        
        // Espacio es igual a Velocidad por Tiempo
        let cantidad = velocity * CGFloat(dt)
        sprite.position += cantidad
    }
    
    func policiaToLocation(location: CGPoint) {
        
        //  Cantidad de movimiento que debemos darle al policia para llegar donde hemos tocado
        let offset = location - policia.position
        
        
        // Vector unitario de movimiento
        let direccion = offset.normaliza()
        velocityPolicia = direccion * policiaPixelPerSecond
    }
    
    func sceneTouched(touchLocation: CGPoint){
        
        lastTouchLocation = touchLocation
        policiaToLocation(location: touchLocation)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        policia.run(policiaCaminandoDer)
        
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
    
    
   /* func rotateSprite(sprite: SKSpriteNode, direction: CGPoint) {
        
        let shortestAngle = shorterAngleBetween(angle1: velocityPolicia.angle, angle2: sprite.zRotation)
        let cantidadRotacion = min(policiaAnglePerSecond * CGFloat(dt), abs(shortestAngle))
        
        sprite.zRotation += cantidadRotacion * shortestAngle.signo()
        
        
//        sprite.zRotation = atan2(direction.y, direction.x)
    }*/
    
  
    
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
        
        corona.position = CGPoint(x: size.width + corona.size.width/2, y: size.height/2)
        addChild(corona)
    
  
      //  let actionFirstMove = SKAction.move(to: CGPoint(x: size.width/2, y: playableArea.minY + corona.size.height/2), duration: 2.0)
        let actionFirstMove = SKAction.moveBy(x: -corona.size.width/2 - size.width/2, y: -size.height/2 + corona.size.height/2, duration: 2.0)
      
        
        let actionWait = SKAction.wait(forDuration: 1.0)
      //  let actionSecondMove = SKAction.move(to: CGPoint(x: playableArea.minX, y: corona.position.y), duration: 2.0)
    
        let actionSecondMove = SKAction.moveBy(x: -corona.size.width/2 - size.width/2, y: playableArea.height/2 + size.height/2, duration: 2.0)
       
        let killNodo = SKAction.removeFromParent()
    
        let firstSecuence = SKAction.sequence([actionFirstMove, actionWait, actionSecondMove])
        let reverseSecuence = firstSecuence.reversed()
        
        let secuence = SKAction.sequence([firstSecuence, reverseSecuence, killNodo])
    
        corona.run(secuence)
   
      }
 
  
}

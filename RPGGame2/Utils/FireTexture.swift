//
//  FireTexture.swift
//  RPGGame2
//
//  Created by Datita Devindo Bahana on 24/05/23.
//

import Foundation
import SpriteKit

class Fire: SKSpriteNode {
    var orientation:Int = 1 // 1:left, 2 right
    var elapsedTime: TimeInterval = 0.0
    
    func update(_ deltaTime: TimeInterval) {
//        var deltaTime = currentTime - lastUpdateTime
//        lastUpdateTime = currentTime
//        print(deltaTime)
        var newXPosition:CGFloat = 0
        elapsedTime += deltaTime
        
        if elapsedTime >= 0.08 {
//            print(elapsedTime)
            if(self.orientation == 1){
                newXPosition = position.x + 10
            }else{
                newXPosition = position.x - 10
            }
            elapsedTime = 0.0
            position = CGPoint(x: newXPosition, y: position.y)
        }
        
        // Set the new position
        
        
        
    }

    func didBegin(_ contact: SKPhysicsContact) {
       // Handle collision logic here
    }
}

func fireRightTexture() -> [SKTexture]{
    var texture:[SKTexture] = []
    
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "Flame_Right\(i)"))
    }
    
    return texture
}

func fireLeftTexture() -> [SKTexture]{
    var texture:[SKTexture] = []
    
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "Flame_Left\(i)"))
    }
    
    return texture
}

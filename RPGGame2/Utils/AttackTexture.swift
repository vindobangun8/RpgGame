//
//  AttackUtils.swift
//  RPGGame2
//
//  Created by Datita Devindo Bahana on 23/05/23.
//

import Foundation
import SpriteKit


func attack1RightTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...5{
        texture.append(SKTexture(imageNamed: "attack1_Right\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}

func attack1LeftTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...5{
        texture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}



func attack2RightTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "attack2_Right\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}

func attack2LeftTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "attack2_Left\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}

func attack3LeftTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "attack3_Left\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}

func attack3RightTexture() -> [SKTexture]{
    var texture : [SKTexture] = []
    for i in 1...4{
        texture.append(SKTexture(imageNamed: "attack3_Right\(i)"))
//            attackLeftTexture.append(SKTexture(imageNamed: "attack1_Left\(i)"))
    }
    return texture
}

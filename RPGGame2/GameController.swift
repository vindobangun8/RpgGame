//
//  GameController.swift
//  RPGGame2
//
//  Created by Datita Devindo Bahana on 25/05/23.
//

import Foundation
import SpriteKit

class GameController: ObservableObject {
    @Published var scene = SKScene(fileNamed: "GameScene")
//    @Published var play : Bool = false
//    @Published var gameOver: Bool = false
//    @Published var life: Double = 3
    @Published var score: Int = 0
//    @Published var weapon: Int = 0
    
    func restart() {
        scene  = SKScene(fileNamed: "GameScene")
        score = 0
//        life = 3
//        weapon = 0
//        gameOver = false
        
    }
    func respawn() {
        scene  = SKScene(fileNamed: "GameScene")
        if let gameScene = scene as? GameScene {
            gameScene.controller = self
        }
        
    }
}

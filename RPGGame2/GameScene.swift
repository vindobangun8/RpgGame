//
//  GameScene.swift
//  RPGGame2
//
//  Created by Datita Devindo Bahana on 22/05/23.
//

import SpriteKit
import SwiftUI
import GameplayKit






//struct EmitterView: UIViewRepresentable {
//    /**
//    makeUIView and updateUIView are required methods of the UIViewRepresentable
//    protocol. makeUIView does just what you'd think - makes the view we want.
//
//    updateUIView allows you to update the view with new data, but we don't need
//    it for our purposes.
//    */
//    func makeUIView(context: UIViewRepresentableContext<EmitterView>) -> SKView {
//        // Create our SKView
//        let view = SKView()
//        // We want the view to animate the particle effect over our SwiftUI view
//        // and let its components show through so we'll set allowsTransparenty to true.
//        view.allowsTransparency = true
//        // Load our custom SKScene
//        if let scene = GameScene(fileNamed: "GameScene") {
//            // We need to set the background to clear.
//            scene.backgroundColor =  .clear
//            scene.scaleMode = .aspectFill
//            view.presentScene(scene)
//        }
//        return view
//    }
//
//    func updateUIView(_ uiView: SKView, context: UIViewRepresentableContext<EmitterView>) {
//
//    }
//
//}
class GameScene: SKScene,SKPhysicsContactDelegate {
    var controller : GameController?
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var player = SKSpriteNode(imageNamed: "Idle_right")
    var joystick: SKSpriteNode!
    var aButton: SKSpriteNode!
    var bButton: SKSpriteNode!
    var isJoystickActive = false
    var isAButtonActive = false
    var isPosLeft = false
    var isPosRight = true
    var joystickPosition: CGPoint = .zero
    var joystickDefaultPos:CGPoint!
    var normPosX:CGFloat = 0
    var normPosY:CGFloat = 0
    var playerPosx: CGFloat = 0
    var playerPosy: CGFloat = 0
    var playerSizeDefault: CGSize!
    var attackRightTexture: [SKTexture]  = []
    var attackLeftTexture: [SKTexture]  = []
    var attackOrder:Int = 1
    var lastUpdateTime:TimeInterval! = 0
    let jumpForce: CGFloat = 80
    var isAttack = false
//    var audioPlayer:AVAudioPlayer?
    
    
  
    
//    var virtualController :GCVirtualController?
//    var warriorAnimation : SKAction!
//    func playSound() {
//        print("msuk isni")
//            guard let soundURL = Bundle.main.url(forResource: "FireBall", withExtension: "mp3") else { return }
//
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//                audioPlayer?.play()
//            } catch {
//                print("Tidak dapat memainkan suara: \(error.localizedDescription)")
//            }
//        }
    
    func addPlayer(){
//        player =
        player.name = "player"
        player.size = CGSize(width:60 /* desired width */, height:86 /* desired height */)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.position = CGPoint(x: 40, y: -77/* desired y position */)
        player.physicsBody?.friction = 1
        player.physicsBody?.restitution = 0.2
        player.physicsBody?.linearDamping = 0
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        addChild(player)
    }
    
    func jump() {
        // Check if the character is on the ground before allowing a jump
        guard player.physicsBody?.velocity.dy == 0 else {
            return
        }

        // Apply the upward force to make the character jump
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpForce))
    }
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        addPlayer()
        joystick = self.childNode(withName: "Joystick") as? SKSpriteNode
        aButton = self.childNode(withName: "aButton") as? SKSpriteNode
        bButton = self.childNode(withName: "bButton") as? SKSpriteNode
        joystickDefaultPos = joystick.position
        playerSizeDefault = player.size
        
        let spawnAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 5),
            SKAction.run(spawnMonster)
        ]))
//        print(player?.physicsBody)
        run(spawnAction)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
            guard let nodeA = contact.bodyA.node else { return }
            guard let nodeB = contact.bodyB.node else { return }
            
            
            if (nodeB.name == "fire" && nodeA.name == "monster") || (nodeA.name == "fire" && nodeB.name == "monster"){
                removeChildren(in: [nodeA])
                removeChildren(in: [nodeB])
                controller?.score += 1
            }
        if (nodeB.name == "player" && nodeA.name == "monster") || (nodeA.name == "player" && nodeB.name == "monster" && isAttack){
            if (nodeA.name == "monster" ){
                removeChildren(in: [nodeA])
            }else{
                removeChildren(in: [nodeB])
            }
            controller?.score += 1
        }
        }
    
    
    func spawnMonster() {
        // Create a new instance of your monster sprite
        var monster:Monster
        
        let RandNum = Int.random(in: 1...2)
        
        if(RandNum == 1){
            monster = Monster(imageNamed: "monster_Idle_Left") // right position spawn
            monster.orientation = 2
            monster.position = CGPoint(x: 377, y: -90/* desired y position */)
            
        }else{
            monster = Monster(imageNamed: "monster_Idle_Right") // left position spawn
            monster.orientation = 1
            monster.position = CGPoint(x: -377, y: -90/* desired y position */)
        }
        monster.name = "monster"
//        monster.texture =
        monster.size = CGSize(width:60 /* desired width */, height:60 /* desired height */)
        monster.physicsBody = SKPhysicsBody(texture: monster.texture!, size: monster.size)
        monster.physicsBody?.friction = 1
        monster.physicsBody?.restitution = 1
        monster.physicsBody?.linearDamping = 0
        monster.physicsBody?.angularDamping = 0
        monster.physicsBody?.allowsRotation = false
        monster.physicsBody?.isDynamic = true
//        monster.physicsBody = SKPhysicsBody(
        // Add the monster to the scene
        addChild(monster)
        
      
//        monsters.append(monster)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if joystick.contains(location) {
                isJoystickActive = true
                joystickPosition = location
            }
            // Attack Button
            if aButton.contains(location){
                
                if(isPosRight){
                    if attackOrder == 1{
                        attackRightTexture = attack1RightTexture()
                        attackOrder = 2
                    }else if attackOrder == 2{
                        attackRightTexture = attack2RightTexture()
                        
//                        print(attackRightTexture)
                        attackOrder = 3
                    }else if attackOrder == 3{
                        attackRightTexture = attack3RightTexture()
                        
//                        print(attackRightTexture)
                        attackOrder = 1
                    }
                    attackRightTexture.append(SKTexture(imageNamed: "Idle_right"))
                    let warriorAnimations = SKAction.animate(with: attackRightTexture, timePerFrame: 0.09)
                    player.run(warriorAnimations)
                    attackRightTexture.removeLast()
                }else{
                    if attackOrder == 1 {
                        attackLeftTexture = attack1LeftTexture()
                        attackOrder = 2
                    }else if attackOrder == 2{
                        attackLeftTexture = attack2LeftTexture()
                        attackOrder = 3
                    }else if attackOrder == 3{
                        attackLeftTexture = attack3LeftTexture()
                        attackOrder = 1
                    }
                    attackLeftTexture.append(SKTexture(imageNamed: "Idle_left"))
                    let warriorAnimations = SKAction.animate(with: attackLeftTexture, timePerFrame: 0.1)
                    player.run(warriorAnimations)
                    isAttack = true
                    attackLeftTexture.removeLast()
                }
                let sound = SKAction.playSoundFileNamed("Sword.wav", waitForCompletion: false)
                run(sound)
            }
            else if bButton.contains(location){
                var fire:Fire
                fire = Fire(imageNamed: "Flame1")
//                fire = SKSpriteNode(imageNamed: "Flame1")
                var charaPos = player.position
                if(isPosLeft){
                    charaPos.x -= 40
                    charaPos.y -= 10
                }else{
                    charaPos.x += 40
                    charaPos.y -= 10
                }
                fire.name = "fire"
                fire.size = CGSize(width:50 , height:30 )
                fire.position = charaPos
                fire.physicsBody = SKPhysicsBody(rectangleOf: fire.size)
                fire.physicsBody?.affectedByGravity = false
                fire.physicsBody?.friction = 0
                fire.physicsBody?.restitution = 0
                fire.physicsBody?.linearDamping = 0
                fire.physicsBody?.angularDamping = 0
                fire.physicsBody?.allowsRotation = false
                fire.physicsBody?.isDynamic = true
                fire.physicsBody!.contactTestBitMask = fire.physicsBody!.collisionBitMask
                
                
                let fireTexture :[SKTexture]
                var attackTexture : [SKTexture]
                if(isPosLeft){
                    attackTexture = attack1LeftTexture()
                    attackTexture.append(SKTexture(imageNamed: "Idle_left"))
                    fireTexture = fireLeftTexture()
                    fire.orientation = 2
                    
                }else{
                    attackTexture = attack1RightTexture()
                    attackTexture.append(SKTexture(imageNamed: "Idle_right"))
                    fireTexture = fireRightTexture()
                    fire.orientation = 1
                }
                
                addChild(fire)
                let fireAnimations = SKAction.animate(with: fireTexture, timePerFrame: 0.1)
                let warriorAnimations = SKAction.animate(with: attackTexture, timePerFrame: 0.1)
                player.run(warriorAnimations)
                fire.run(SKAction.repeatForever(fireAnimations))
                let sound = SKAction.playSoundFileNamed("FIreBall.mp3", waitForCompletion: false)
                run(sound)

            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches {
//            self.touchMoved(toPoint: t.location(in: self)) }
        guard isJoystickActive else { return }
        for touch in touches {
            let location = touch.location(in: self)
            let dx = location.x - joystickPosition.x
            let dy = location.y - joystickPosition.y
            let distance = hypot(dx, dy)
            
            
            if distance <= joystick.frame.size.width {
                joystick.position = location
            } else {
                let angle = atan2(dy, dx)
                let newX = joystickPosition.x + cos(angle) * joystick.frame.size.width
                let newY = joystickPosition.y + sin(angle) * joystick.frame.size.width
                joystick.position = CGPoint(x: newX, y: newY)
            }
            
            // Normalize the joystick position to get values between -1 and 1
            normPosX = (joystick.position.x - joystickPosition.x) / joystick.frame.size.width
            normPosY = (joystick.position.y - joystickPosition.y) / joystick.frame.size.width
            // Use the normalized values to control your game character or object's movement
            // Implement your movement logic here based on the normalizedX and normalizedY values
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isJoystickActive = false
           // Reset the joystick position to its original position or any desired default position
        joystick.position = joystickDefaultPos
        
        normPosX = .zero
        normPosY = .zero
        
        if isPosLeft{
            player.texture = SKTexture(imageNamed: "Idle_left")
        }
        else{
            player.texture = SKTexture(imageNamed: "Idle_right")
        }
        player.size = playerSizeDefault
        isAttack = false
    }
    
    
    override func update(_ currentTime: TimeInterval) {

        if normPosX > 0{
            player.position.x += 1.5
            
            let value = abs(Int(player.position.x / 10) % 7) + 1
            player.texture = SKTexture(imageNamed: "right\(value)")
            isPosLeft = false
            isPosRight = true
        }
        else if normPosX < 0{
            player.position.x -= 1.5
            let value = abs(Int(player.position.x / 10) % 7) + 1
            player.texture = SKTexture(imageNamed: "left\(value)")
            isPosLeft = true
            isPosRight = false
        }
        if normPosY > 0.4{
           jump()
        }
        
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        for case let monster as Monster in children {
                   monster.update(deltaTime)
       }
        for case let fire as Fire in children{
            fire.update(deltaTime)
        }

    }
    
}


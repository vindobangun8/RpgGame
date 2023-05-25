//
//  ContentView.swift
//  SwiftUIWithSprite
//
//  Created by Muhammad Tafani Rabbani on 22/05/23.
//

import SwiftUI
import SpriteKit

//protocol GameLogicDelegate {
//    var totalScoreObama: Int { get }
//    var totalScoreTrump: Int { get }
//
//    mutating func addPointObama() -> Void
//    mutating func addPointTrump() -> Void
//}
//
struct GameView: View {
    @ObservedObject var gameController: GameController
    var body: some View {
        ZStack(alignment: .topLeading) {
           
//            EmitterView()
            SpriteView(scene: gameController.scene!)
                .ignoresSafeArea()
                .onAppear{
                    if let gameScene = gameController.scene as? GameScene {
                        gameScene.controller = gameController
                    }
                }
                .scaleEffect(1.1)
//            VStack{
//                Text("Score")
//                    .font(.largeTitle)
//                    .bold()
//
//                Text("\(gameController.score)")
//                    .font(.largeTitle)
//                Spacer()
//            }
            HStack{
                Text("Score")
                    .font(.largeTitle)
                    .bold()
                
                Text("\(gameController.score)")
                    .font(.largeTitle)
            }
            .padding(36)
           
        } .ignoresSafeArea()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

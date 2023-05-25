//
//  ContentView.swift
//  RPGGame2
//
//  Created by Datita Devindo Bahana on 22/05/23.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var gameController: GameController = GameController()
    var body: some View {
        NavigationView{
            ZStack{
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack{
                    Spacer()
                    Image("Title")
                        .resizable()
                        .frame(maxWidth: 800,maxHeight:150)
                    Spacer()
                    NavigationLink(destination: GameView(gameController:gameController)
                        .navigationBarBackButtonHidden(true)
                        .edgesIgnoringSafeArea(.all)){
                            //                            EmptyView()
                            Image("StartButton")
                            
                        }
                    
                    Spacer()
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            } .edgesIgnoringSafeArea(.all)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

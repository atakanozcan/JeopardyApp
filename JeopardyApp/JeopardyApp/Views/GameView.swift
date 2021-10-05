//
//  GameView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct GameView: View {
    @EnvironmentObject var model: GameModel
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            NavigationView {
                switch viewModel.gameState {
                case .start:
                    VStack {
                        Text("Welcome to Jeopardy!")
                        NavigationLink(destination: CategoriesList(viewModel: CategoriesViewModel(self.model, isDoubleJeopardy: false)).navigationTitle("Jeopardy!")) {
                            Text("Start Game")
                        }
                    }
                case .finishedJeopardy:
                    VStack {
                        Text("You finished the Jeopardy Round")
                        NavigationLink(destination: CategoriesList(viewModel: CategoriesViewModel(self.model, isDoubleJeopardy: true)).navigationTitle("Double Jeopardy!")) {
                            Text("Continue to Double Jeopardy!")
                        }
                    }
                case .finishDoubleJeopardy:
                    VStack {
                        Text("You finished the Double Jeopardy Round")
                        NavigationLink(destination: FinalJeopardyView(viewModel: FinalJeopardyViewModel(model)).navigationTitle("Final Jeopardy!")) {
                            Text("Continue to Final Jeopardy!")
                        }
                    }
                case .finishedFinalJeopardy:
                    VStack {
                        Text("You finished the game!")
                        Text("And won \(model.currentCash)")
                    }
            }
        }
               
            VStack {
                HStack {
                    Text("Current Cash:")
                    Text(model.currentCash.description)
                }
            }
            Spacer()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    static var previews: some View {
        GameView(viewModel: GameViewModel(model)).environmentObject(model)
    }
}

//
//  GameView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    init(_ model: GameModel) {
        self.viewModel = GameViewModel(model)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                switch viewModel.gameState {
                case .start:
                    VStack {
                        Text("This is Jeopardy!").font(.largeTitle)
                        Text("Today's contestant is you!").font(.headline)
                        NavigationLink(destination: CategoriesList(viewModel: CategoriesViewModel(viewModel.model, isDoubleJeopardy: false)).navigationTitle("Jeopardy!")) {
                            Text("Start Playing")
                        }
                    }
                case .finishedJeopardy:
                    VStack {
                        Text("You finished the Jeopardy Round")
                        NavigationLink(destination: CategoriesList(viewModel: CategoriesViewModel(viewModel.model, isDoubleJeopardy: true)).navigationTitle("Double Jeopardy!")) {
                            Text("Continue to Double Jeopardy!")
                        }
                    }
                case .finishedDoubleJeopardy:
                    VStack {
                        Text("You finished the Double Jeopardy Round")
                        NavigationLink(destination: FinalJeopardyView(viewModel: FinalJeopardyViewModel(viewModel.model)).navigationTitle("Final Jeopardy!")) {
                            Text("Continue to Final Jeopardy!")
                        }
                    }
                case .finishedFinalJeopardy:
                    VStack {
                        Text("You finished the game!")
                        Text("And won \(viewModel.currentCash) dollars!")
                        Button("Play again!") {
                            viewModel.restartGame()
                        }
                    }
                }
            }
            VStack {
                HStack {
                    Text("Current Cash:")
                    Text(viewModel.currentCash.description)
                }
            }
            Spacer()
        }.onAppear { viewModel.onAppear() }.alert("A network error occurred while fetching the questions.", isPresented: $viewModel.showNetworkError) {
            Button("Try again") { viewModel.onAppear() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    static var previews: some View {
        GameView(model).environmentObject(model)
    }
}

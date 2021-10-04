//
//  GameView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct GameView: View {
    @ObservedObject var viewModel = GameViewModel()
    @EnvironmentObject var model: GameModel
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Text("Welcome to Jeopardy")
                    NavigationLink(destination: CategoriesList(viewModel: CategoriesViewModel(self.model, isDoubleJeopardy: false))) {
                        Text("Start Game")
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
    private static let model: JeopardyModel.GameModel = MockModel()
    static var previews: some View {
        GameView().environmentObject(model)
    }
}

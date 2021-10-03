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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Jeopardy")
                NavigationLink(destination: CategoriesList(viewModel.model, isDoubleJeopardy: true).environmentObject(viewModel.model)) {
                        Text("Start Game")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    private static let model: JeopardyModel.Model = MockModel()
    static var previews: some View {
        GameView().environmentObject(model)
    }
}

//
//  ContentView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct ContentView: View {
    @EnvironmentObject var model: GameModel
    
    var body: some View {
        VStack {GameView(viewModel: GameViewModel(self.model))}.environmentObject(self.model)
    }
}

struct ContentView_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    static var previews: some View {
        ContentView().environmentObject(model)
    }
}

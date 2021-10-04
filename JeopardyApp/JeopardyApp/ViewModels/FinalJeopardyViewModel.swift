//
//  FinalJeopardyViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 4.10.2021.
//

import Foundation
import JeopardyModel

class FinalJeopardyViewModel: ObservableObject {
    @Published var clue: Clue
    private let model: GameModel
    
    init(_ model: GameModel) {
        self.model = model
        self.clue = model.finalJeopardy
    }
    
    public var categoryTitle: String {
        model.category(clue.categoryId)?.title.uppercased() ?? ""
    }
    
    public var currentCash: Int {
        model.currentCash
    }
}

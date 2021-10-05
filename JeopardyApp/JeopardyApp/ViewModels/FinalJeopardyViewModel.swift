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
        self.clue = model.finalJeopardy.clues.first ?? Clue(id: 0, difficulty: 0, categoryId: 0, question: "", answer: "")
    }
    
    public var categoryTitle: String {
        model.category(clue.categoryId)?.title.uppercased() ?? ""
    }
    
    public var currentCash: Int {
        model.currentCash
    }
}

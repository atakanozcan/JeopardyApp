//
//  QuestionViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 4.10.2021.
//

import Foundation
import JeopardyModel
import SwiftUI

class QuestionViewModel: ObservableObject {
    
    @Published var clue: Clue
    private let model: GameModel
    var finalBet: Int?
    
    init(_ model: GameModel, categoryId: Int, clueId: Int, finalBet: Int? = nil) {
        self.model = model
        self.clue = model.clue(categoryId: categoryId, clueId: clueId) ?? Clue(id: 0, difficulty: 0, categoryId: 0, question: "", answer: "")
        self.finalBet = finalBet
    }
    
    public var categoryTitle: String {
        model.category(clue.categoryId)?.title.uppercased() ?? ""
    }
    
    public var isAnswered: Bool {
        model.isAnswered(categoryId: clue.categoryId, clueId: clue.id)
    }
    
    public var questionString: String {
        clue.question.uppercased()
    }
    
    public var difficulty: String {
        "$" + clue.difficulty.description
    }
    
    public var isFinalJeopardy: Bool {
        finalBet != nil
    }
    
    public func answer(_ answer: String) {
        isFinalJeopardy ?
        model.answerFinalJeopardy(answer: answer, bet: finalBet ?? 0) :
        model.answer(categoryId: self.clue.categoryId, clueId: self.clue.id, answer: answer)
    }
    
    public func pass() {
        model.pass(categoryId: self.clue.categoryId, clueId: self.clue.id)
    }
}

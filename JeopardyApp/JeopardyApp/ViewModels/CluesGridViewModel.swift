//
//  CluesGridViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

import Foundation
import JeopardyModel
import SwiftUI

class CluesGridViewModel: ObservableObject {
    
    @Published var clues: [JeopardyModel.Clue]
    private var category: JeopardyModel.Category?
    @Published var categoryId: Int
    private let model: Model
    
    init(_ model: Model, _ categoryId: Int) {
        self.model = model
        self.categoryId = categoryId
        self.category = model.category(categoryId)
        self.clues = category?.clues ?? []
    }
    
    public var categoryTitle: String {
        category?.title.uppercased() ?? ""
    }
    
    public var answeredClues: [Clue] {
        var answered = [Clue]()
        
        for clue in clues {
            if model.answeredClues.contains(where: {$0.id == clue.id}) {
                answered.append(clue)
            }
        }
        return answered
    }
    
    public var isGridFinished: Bool {
        var finished: Bool = false
        for clue in self.clues {
            finished = finished && model.answeredClues.contains(where: { $0.id == clue.id })
        }
        return finished
    }
    
    public func getQuestionWithClue(_ idx: Int) -> String {
        clues[idx].question.uppercased()
    }
    
    public func getDifficultyOfClue(_ idx: Int) -> String {
        "$" + clues[idx].difficulty.description
    }
    
    public func answer(_ clueIdx: Int, _ answer: String) {
        model.answer(categoryId: self.categoryId, clueId: self.clues[clueIdx].id, answer: answer)
    }
    
}

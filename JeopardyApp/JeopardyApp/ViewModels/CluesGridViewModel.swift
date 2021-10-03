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
    
    public func getQuestionWithClue(_ idx: Int) -> String {
        clues[idx].question.uppercased()
    }
    
    public func getDifficultyOfClue(_ idx: Int) -> String {
        "$" + clues[idx].difficulty.description
    }
    
    public func isClueAnswered(_ idx: Int) -> Bool {
        model.answeredClues.contains(where: {$0.id == clues[idx].id})
    }
    
    public func answerCorrectly(_ clueIdx: Int) {
        model.answerCorrectly(categoryId: self.categoryId, clueId: clues[clueIdx].id)
    }
//    var selectedClue: JeopardyModel.Clue? {
//        model?.clue(categoryId: categoryId, clueId: selectedClueId)
//    }
        
//    var money: Int {
//        model?.currentCash ?? 0
//    }
//    func answerCorrectly() {
//        model?.answerCorrectly(categoryId: categoryId, clueId: selectedClueId)
//        print(money.description)
//    }
    
//    func isAnswered() -> Bool {
//        model?.isClueAnswered(clueId: selectedClueId!) ?? false
//    }
    

}

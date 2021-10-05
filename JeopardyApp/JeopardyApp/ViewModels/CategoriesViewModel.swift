//
//  CategoriesViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//
import Foundation
import JeopardyModel
import SwiftUI

class CategoriesViewModel: ObservableObject {
    
    @Published var categories: [JCategory]
    private let model: GameModel
    var isDoubleJeopardy: Bool
    
    
    init(_ model: GameModel, isDoubleJeopardy: Bool) {
        self.model = model
        self.isDoubleJeopardy = isDoubleJeopardy
        self.categories = isDoubleJeopardy ? model.doubleJeopardy : model.jeopardy
    }
    
    func getCategoryTitleWith(_ categoryId: Int) -> String {
        return categories.first(where: { $0.id == categoryId })?.title.uppercased() ?? ""
    }
    
    func getCluesForCategoryWith(_ categoryId: Int) -> [JeopardyModel.Clue] {
        return categories.first(where: { $0.id == categoryId })?.clues ?? []
    }
    
    func getClueAmountForCategoryWith(_ categoryId: Int) -> [String] {
        var amountStrings = [String]()
        for amount in model.remainingAmountsForCategory(cstegoryId: categoryId) {
            amountStrings.append("$"+amount.description)
        }
        return amountStrings
    }
    
    func idOfTheCategoryWith(_ idx: Int) -> Int {
        return categories[idx].id
    }
    
    public var isCategoriesFinished: Bool {
        isDoubleJeopardy ? model.isDoubleJeopardyFinished() : model.isJeopardyFinished()
    }
}

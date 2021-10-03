////
////  CategoryViewModel.swift
////  JeopardyApp
////
////  Created by Atakan Özcan on 3.10.2021.
////
//
//import Foundation
//import JeopardyModel
//import SwiftUI
//
//class CategoryViewModel: ObservableObject {
//
//    @Published var category: JeopardyModel.Category
//    @Published private var model: Model
//    var categoryId: Int
//
//    
//    init(_ model: Model, _ categoryId: Int) {
//        self.model = model
//        self.categoryId = categoryId
//        self.category = model.category(categoryId) ?? <#default value#>
//    }
//    
//    var categoryTitle
//    func getCategoryTitleWith(_ idx: Int) -> String {
//        return categories[idx].title.uppercased()
//    }
//    
//    func getCluesForCategoryWith(_ idx: Int) -> [JeopardyModel.Clue] {
//        return categories[idx].clues
//    }
//    
//    func getClueAmountForCategoryWith(_ categoryIdx: Int) -> [String] {
//        var amountStrings = [String]()
//        for clue in categories[categoryIdx].clues {
//            if !model.answeredClues.contains(where: { $0.id == clue.id }) {
//                amountStrings.append("$" + clue.difficulty.description)
//            }
//        }
//        return amountStrings
//    }
//    
//    func idOfTheCategoryWith(_ idx: Int) -> Int {
//        return categories[idx].id
//    }
//}

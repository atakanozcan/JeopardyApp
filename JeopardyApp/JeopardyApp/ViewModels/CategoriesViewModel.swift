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

    var isDoubleJeopardy: Bool
    
    var categories: [JeopardyModel.Category] {
        model?.categories(isDoubleJeopardy: isDoubleJeopardy) ?? []
    }
    
    private weak var model: Model?

    
    init(_ model: Model, isDoubleJeopardy: Bool) {
        self.model = model
        self.isDoubleJeopardy = isDoubleJeopardy
    }
    
}

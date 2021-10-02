//
//  CluesGridViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

import Foundation
import JeopardyModel

class CluesGridViewModel: ObservableObject {
    var id: Int
    
    private weak var model: Model?

    var clues: [JeopardyModel.Clue] {
        model?.category(id)?.clues ?? []
    }
        
    init(_ model: Model, categoryId: Int) {
        self.model = model
        self.id = categoryId
    }
    
}

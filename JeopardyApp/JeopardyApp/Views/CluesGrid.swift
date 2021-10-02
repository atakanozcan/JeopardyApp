//
//  CluesGrid.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CluesGrid: View {
    @ObservedObject private var viewModel: CluesGridViewModel
        
    let columns = [
        GridItem(.adaptive(minimum: 400))
    ]
    
    init(_ model: JeopardyModel.Model, categoryId: Int){
        viewModel = CluesGridViewModel(model, categoryId: categoryId)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.clues.first?.category.uppercased() ?? "")
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewModel.clues) { clue in
                    ClueCell(clue: clue, state: .difficulty)
                }
            }
        }
    }
}

struct CluesGrid_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        CluesGrid(model, categoryId: model.jeopardy.first?.id ?? 0)
        
    }
}

//
//  CategoryCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CategoryCell: View {
    var category: JeopardyModel.Category
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                HStack {
                    Text(category.title.uppercased()).foregroundColor(.white)
                }
                HStack {
                   ForEach(category.clues) { clue in
                       clue.answered ? nil : Text("$" + clue.difficulty.description).foregroundColor((Color(red: 230/255, green: 165/255, blue:90/255)))
                    }
                }
            }
            Image(systemName: "chevron.right").foregroundColor(.white)
        }.padding(5)
            .background(Rectangle().fill(Color(red: 30/255, green: 30/255, blue: 187/255)))
    }
}

struct CategoryCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        CategoryCell(category: model.category1!)
    }
}

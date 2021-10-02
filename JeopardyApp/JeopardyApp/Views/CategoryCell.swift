//
//  CategoryCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CategoryCell: View {
    @EnvironmentObject var model: Model

    var id: JeopardyModel.Category.ID
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                HStack {
                    Text(model.category(id)?.title.uppercased() ?? "")
                        .font(.custom("HelveticaNeue", size: 24).bold())
                        .foregroundColor(.white)
                }
                HStack {
                    ForEach(model.category(id)?.clues ?? []) { clue in
                       clue.answered ? nil : Text("$" + clue.difficulty.description).foregroundColor(Color("JeopardySecondaryColor"))
                    }
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7)
                .foregroundColor(.white)
        }.padding(15)
        .background(Rectangle().fill(Color("JeopardyColor")))
    }
}

struct CategoryCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    private static var categoryId = model.jeopardy[0].id

    
    static var previews: some View {
        CategoryCell(id: categoryId).environmentObject(model)
    }
}

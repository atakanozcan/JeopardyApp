//
//  CategoryCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CategoryCell: View {
    @Binding var category: JCategory
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                HStack {
                    Text(viewModel.getCategoryTitleWith(category.id))
                        .font(.custom("HelveticaNeue", size: 24).bold())
                        .foregroundColor(.white)
                        .opacity(viewModel.getClueAmountForCategoryWith(category.id).isEmpty ? 0 : 1)
                }
                HStack {
                    ForEach(viewModel.getClueAmountForCategoryWith(category.id).indices, id: \.self) {
                        Text(viewModel.getClueAmountForCategoryWith(category.id)[$0]).foregroundColor(Color("JeopardySecondaryColor"))
                    }
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7)
                .foregroundColor(.white)
                .opacity(viewModel.getClueAmountForCategoryWith(category.id).isEmpty ? 0 : 1)
        }.padding(15)
        .background(Rectangle().fill(Color("JeopardyColor")))
    }
}

struct CategoryCell_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    
    static var previews: some View {
        CategoryCell(category: .constant(model.jeopardy.first!), viewModel: CategoriesViewModel(model, isDoubleJeopardy: true))
    }
}

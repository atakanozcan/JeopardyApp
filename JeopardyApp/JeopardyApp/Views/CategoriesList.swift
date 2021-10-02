//
//  CategoriesList.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CategoriesList: View {
    @EnvironmentObject var model: JeopardyModel.Model
    @ObservedObject private var viewModel: CategoriesViewModel
    
    init(_ model: JeopardyModel.Model, isDoubleJeopardy: Bool) {
        viewModel = CategoriesViewModel(model, isDoubleJeopardy: isDoubleJeopardy)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.categories) { category in
                CategoryCell(id: category.id).background(
                    NavigationLink(destination: CluesGrid(model, categoryId: category.id)) {}
                       .opacity(0)
                ).listRowBackground( Rectangle().fill(Color("JeopardyColor"))).listRowSeparatorTint(.black)
            }
        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        NavigationView {
            CategoriesList(model, isDoubleJeopardy: false)
                .navigationTitle("Categories")
                .environmentObject(model)
        }
    }
}
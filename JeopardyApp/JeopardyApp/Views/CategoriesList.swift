//
//  CategoriesList.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CategoriesList: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @EnvironmentObject var model: GameModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                ForEach($viewModel.categories) { $category in
                    CategoryCell(category: $category, viewModel: viewModel).background(
                        NavigationLink(destination: CluesGrid(viewModel: CluesGridViewModel(self.model, category.id))) {}
                            .disabled(viewModel.getClueAmountForCategoryWith(category.id).isEmpty)
                            .opacity(0)
                    ).listRowBackground( Rectangle().fill(Color("JeopardyColor"))).listRowSeparatorTint(.black)
                }
            }
        }.onAppear {
            if viewModel.isCategoriesFinished {
                mode.wrappedValue.dismiss()
            }
        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    
    static var previews: some View {
        NavigationView {
            CategoriesList(viewModel: CategoriesViewModel(model, isDoubleJeopardy: true))
                .environmentObject(model)
                .navigationTitle("Categories")
        }
    }
}

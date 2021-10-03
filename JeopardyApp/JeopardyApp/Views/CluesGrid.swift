//
//  CluesGrid.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CluesGrid: View {
    @ObservedObject var viewModel: CluesGridViewModel
    @EnvironmentObject var model: JeopardyModel.Model
    @State var openSheet: Bool = false
    @State var selectedClueIdx: Int?
    
    init(_ model: JeopardyModel.Model, _ categoryId: Int) {
        viewModel = CluesGridViewModel(model, categoryId)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 400))
    ]
    
    var body: some View {
        VStack {
            Text(viewModel.categoryTitle)
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.clues.indices,  id: \.self) { index in
                    ClueCell(viewModel: viewModel, idx: index, state: .difficulty)
                        .onTapGesture {
                            selectedClueIdx = index
                           if !(viewModel.isClueAnswered(index)) {
                               viewModel.answerCorrectly(index)
                               openSheet.toggle()
                           }
                        }
                }
            }
        }.sheet(isPresented: $openSheet) { QuestionView(viewModel: self.viewModel, clueIdx: self.selectedClueIdx ?? 0)
        }
    }
}

struct CluesGrid_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        CluesGrid(model, model.jeopardy.first?.id ?? 0).environmentObject(model)
        
    }
}

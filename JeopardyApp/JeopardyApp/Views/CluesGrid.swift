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
    @EnvironmentObject var model: GameModel
    @State var selectedClueIdx: Int? = nil
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    init(viewModel: CluesGridViewModel) {
        self.viewModel = viewModel
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 400))
    ]
    
    var body: some View {
        VStack {
            Text(viewModel.categoryTitle).font(.title).frame(alignment: .center)
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.clues.indices,  id: \.self) { index in
                    ClueCell(viewModel: QuestionViewModel(self.model, categoryId: viewModel.categoryId, clueId: viewModel.clues[index].id), state: .difficulty)
                        .onTapGesture {
                            if !(viewModel.answeredClues.contains(where: { $0.id == viewModel.clues[index].id })) { //if the clue is already answered, don't select it
                                self.selectedClueIdx = index
                            }
                        }
                }
            }
        }.sheet(item: $selectedClueIdx) { QuestionView(viewModel: QuestionViewModel(self.model, categoryId: viewModel.categoryId, clueId: viewModel.clues[$0].id))
            }
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}


struct CluesGrid_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    
    static var previews: some View {
        CluesGrid(viewModel: CluesGridViewModel(model, model.jeopardy.first?.id ?? 0)).environmentObject(model)
        
    }
}

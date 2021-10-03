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
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.clues.indices,  id: \.self) { index in
                    ClueCell(viewModel: viewModel, idx: index, state: .difficulty)
                        .onTapGesture {
                            if !(viewModel.answeredClues.contains(where: { $0.id == viewModel.clues[index].id })) {
                                self.selectedClueIdx = index
                            }
                        }
                }
            }
        }.sheet(item: $selectedClueIdx, onDismiss: {
            if viewModel.isGridFinished {
                self.mode.wrappedValue.dismiss()
            }}) { QuestionView(viewModel: self.viewModel, clueIdx: $0)
            }.navigationTitle(viewModel.categoryTitle)
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}


struct CluesGrid_Previews: PreviewProvider {
    private static let model: Model = MockModel()
    
    static var previews: some View {
        CluesGrid(viewModel: CluesGridViewModel(model, model.jeopardy.first?.id ?? 0)).environmentObject(model)
        
    }
}

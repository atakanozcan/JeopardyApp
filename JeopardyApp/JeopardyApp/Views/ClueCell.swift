//
//  ClueCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct ClueCell: View {
    @ObservedObject var viewModel: CluesGridViewModel
    var idx: Int
    var state: CellState
    
    
    var body: some View {
        switch state {
        case .clue:
            Text(viewModel.getQuestionWithClue(idx))
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 360, height: 200)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
        case .difficulty:
            if viewModel.answeredClues.contains(where: { $0.id == self.viewModel.clues[idx].id }) {
                Rectangle()
                    .fill(Color("JeopardyColor"))
                    .frame(width: 180, height: 100)
                    .border(Color.black, width: 3)
            } else {
                Text(viewModel.getDifficultyOfClue(idx)).font(.custom("HelveticaNeue", size: 45).bold())
                .foregroundColor(Color("JeopardySecondaryColor"))
                .frame(width: 180, height: 100)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
            }
        }
    }
}

struct ClueCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        ClueCell(viewModel: CluesGridViewModel(model, model.jeopardy.first?.id ?? 0), idx: 0, state: .clue)
    }
}

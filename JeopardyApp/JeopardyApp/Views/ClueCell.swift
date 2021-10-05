//
//  ClueCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct ClueCell: View {
    @ObservedObject var viewModel: QuestionViewModel
    var state: CellState
    
    
    var body: some View {
        switch state {
        case .question:
            Text(viewModel.questionString)
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 360, height: 200)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
        case .difficulty:
            if viewModel.isAnswered {
                Rectangle()
                    .fill(Color("JeopardyColor"))
                    .frame(width: 180, height: 100)
                    .border(Color.black, width: 3)
            } else {
                Text(viewModel.difficulty).font(.custom("HelveticaNeue", size: 45).bold())
                    .foregroundColor(Color("JeopardySecondaryColor"))
                    .frame(width: 180, height: 100)
                    .background(
                        Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
            }
        }
    }
}

enum CellState {
    case question
    case difficulty

}

struct ClueCell_Previews: PreviewProvider {
    private static let model: GameModel = MockModel()
    
    static var previews: some View {
        ClueCell(viewModel: QuestionViewModel(model, categoryId: model.jeopardy.first?.id ?? 0, clueId: model.jeopardy.first?.clues.first?.id ?? 0), state: .question)
    }
}

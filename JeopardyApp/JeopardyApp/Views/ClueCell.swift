//
//  ClueCell.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 29.09.2021.
//

import SwiftUI
import JeopardyModel

struct ClueCell: View {
    var clue: JeopardyModel.Clue
    var state: CellState
    
    
    var body: some View {
        switch state {
        case .clue:
            Text(clue.question.uppercased())
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .foregroundColor(Color("JeopardySecondaryColor"))
                .frame(width: 360, height: 200)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
        case .difficulty:
            Text("$" + clue.difficulty.description).font(.custom("HelveticaNeue", size: 45).bold())
                .foregroundColor(Color("JeopardySecondaryColor"))
                .frame(width: 180, height: 100)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
        }
    }
}

struct ClueCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        ClueCell(clue: Clue(id: 87635, difficulty: 100, category: "acting families", question: "Ronny & the Daytonas wanted to turn it on, wind it up & blow it out", answer: "O\\'Neal", answered: false)
, state: .clue)
    }
}

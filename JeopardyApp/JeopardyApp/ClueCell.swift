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
            Text(clue.question).font(Font.system(size: 45, weight: .bold))
                .foregroundColor(Color(red: 230/255, green: 165/255, blue:90/255))
                .frame(width: 180, height: 100)
                .background(
            Rectangle().fill(Color(red: 30/255, green: 30/255, blue: 187/255)))
        case .difficulty:
            Text("$" + clue.difficulty.description).font(Font.system(size: 45, weight: .bold))
                .foregroundColor(Color(red: 230/255, green: 165/255, blue:90/255))
                .frame(width: 180, height: 100)
                .background(
            Rectangle().fill(Color(red: 30/255, green: 30/255, blue: 187/255)))
        }
        
    }
}

struct ClueCell_Previews: PreviewProvider {
    private static let model: Model = MockModel()

    static var previews: some View {
        ClueCell(clue: model.clue1!, state: .difficulty)
    }
}

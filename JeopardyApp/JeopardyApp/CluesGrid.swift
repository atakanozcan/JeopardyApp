//
//  CluesGrid.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 30.09.2021.
//

import SwiftUI
import JeopardyModel

struct CluesGrid: View {
    var clues: [JeopardyModel.Clue]
    
    let columns = [
        GridItem(.adaptive(minimum: 400))
    ]
    
    var body: some View {
        VStack {
            Text(clues.first?.category.uppercased() ?? "")
        
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(clues) { clue in
                    ClueCell(clue: clue, state: .difficulty)
                }
            }
        }
    }
}

struct CluesGrid_Previews: PreviewProvider {
    static var previews: some View {
        CluesGrid(clues: [Clue(id: 87635, difficulty: 100, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false), Clue(id: 87636, difficulty: 200, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false), Clue(id: 87637, difficulty: 300, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false), Clue(id: 87638, difficulty: 400, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false), Clue(id: 87639, difficulty: 500, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false)])
        
    }
}

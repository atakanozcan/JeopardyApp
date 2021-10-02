//
//  MockModel.swift
//  
//
//  Created by Atakan Özcan on 30.09.2021.
//

import Foundation

public class MockModel: Model {
    public convenience init() {
        let clue1 = Clue(id: 87635, difficulty: 100, category: "acting families", question: "Ryan & Tatum", answer: "O\\'Neal", answered: false)
        let clue2 = Clue(id: 87641, difficulty: 200, category: "acting families", question: "BrothersBen & Casey", answer: "Affleck", answered: false)
        let clue3 = Clue(id: 87647, difficulty: 300, category: "acting families", question: "Dad & sonFreddie", answer: "Prinze", answered: false)
        let clue4 = Clue(id: 87653, difficulty: 400, category: "acting families", question: "Efrem & Stephanie", answer: "Zimbalist", answered: false)
        let clue5 = Clue(id: 87659, difficulty: 500, category: "acting families", question: "Junius & his boys Edwin & John", answer: "Booth", answered: false)
        
        let category1 = Category(title: "acting families", id: 11496, clues: [clue1, clue2, clue3, clue4, clue5])
        
        let jeopardy = [category1, category1, category1, category1, category1, category1]
        
        self.init(currentCash: 0, jeopardy: jeopardy, doubleJeopardy: jeopardy, finalJeopardy: clue1)
        

    }
}

//
//  MockModel.swift
//  
//
//  Created by Atakan Özcan on 30.09.2021.
//

import Foundation

public class MockModel: GameModel {
    public convenience init() {
        let clue11 = Clue(id: 87635, difficulty: 100, categoryId: 11496 , question: "Ryan & Tatum", answer: "O'Neal")
        let clue12 = Clue(id: 87641, difficulty: 200, categoryId: 11496, question: "BrothersBen & Casey", answer: "Affleck")
        let clue13 = Clue(id: 87647, difficulty: 300, categoryId: 11496, question: "Dad & sonFreddie", answer: "Prinze")
        let clue14 = Clue(id: 87653, difficulty: 400, categoryId: 11496, question: "Efrem & Stephanie", answer: "Zimbalist")
        let clue15 = Clue(id: 87659, difficulty: 500, categoryId: 11496, question: "Junius & his boys Edwin & John", answer: "Booth")
        
        
        let clue21 = Clue(id: 87638, difficulty: 100, categoryId: 11499, question: "Students are allowed to bring a toad, a cat or an owl to this fictional boarding school", answer: "Hogwarts")
        let clue22 = Clue(id: 87644, difficulty: 200, categoryId: 11499, question: "This last Ivy-League school to win this college football bowl game was Columbia University in 1934", answer: "the Rose Bowl")
        let clue23 = Clue(id: 87650, difficulty: 300, categoryId: 11499, question: "When \"Face The Nation\" premiered in 1954, this first guest was grilled over comments he had been making about the Army", answer: "Senator Joe McCarthy")
        let clue24 = Clue(id: 87656, difficulty: 400, categoryId: 11499, question: "In 1907, the first 4 groups in this org. started in England were the Bulls, the Wolves, the Curlews & the Ravens", answer: "Boy Scouts")
        let clue25 = Clue(id: 87662, difficulty: 500, categoryId: 11499, question: "On this date in 1999, England's Guardian newspaper announced a coup in the nation of San Seriffe", answer: "April 1st")
        
        let category1 = JCategory(title: "acting families", id: 11496, clues: [clue11, clue12, clue13, clue14, clue15])
        let category2 = JCategory(title: "tough-pourri", id: 11499, clues: [clue21, clue22, clue23, clue24, clue25])



        let jeopardy = [category1, category2, category1, category2, category1, category2]
        
        self.init(currentCash: 0, jeopardy: jeopardy, doubleJeopardy: jeopardy, finalJeopardy: category1)
        

    }
}

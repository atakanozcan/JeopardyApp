//
//  Game.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Game {
    public var currentCash: Int
    public var jeopardy: [Category]
    public var doubleJeopardy: [Category]
    public var finalJeopardy: Clue

    public init(currentCash: Int, jeopardy: [Category], doubleJeopardy: [Category], finalJeopardy: Clue) {
        self.currentCash = currentCash
        self.jeopardy = jeopardy
        self.doubleJeopardy = doubleJeopardy
        self.finalJeopardy = finalJeopardy
    }
}

//
//  Category.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Category: Identifiable {
    public let title: String
    public let id: Int
    public let clues: [Clue]

    public init(title: String, id: Int, clues: [Clue]) {
        self.title = title
        self.id = id
        self.clues = clues
    }
}

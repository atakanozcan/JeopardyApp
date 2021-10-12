//
//  CodableClue.swift
//  
//
//  Created by Atakan Özcan on 5.10.2021.
//

import Foundation

//Intermediary model of the clue with category added for decoding the JSON response
public struct CodableClue: Codable {
    public let id: Int
    public let categoryId: Int
    public let question: String
    public let answer: String
    public let category: JCategory
    
    enum CodingKeys: String, CodingKey {
           case id, question, answer, category
           case categoryId = "category_id"
       }
}

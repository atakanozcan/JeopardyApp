//
//  GameViewModel.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

import Foundation
import JeopardyModel
import SwiftUI

class GameViewModel: ObservableObject {
    private let model: GameModel
    //private let gameService = GameService()
    
    init(_ model: GameModel) {
        self.model = model
    }
    
    public var gameState: GameState {
        if model.isJeopardyFinished() {
            return .finishedJeopardy
        } else if model.isDoubleJeopardyFinished() {
            return .finishDoubleJeopardy
        } else if model.finishedFinalJeopardy {
            return .finishedFinalJeopardy
        } else {
            return .start
        }
    }
    
    
//    func fetchFinalJeopardy() {
//        Task {
//            var categoryArr = [JCategory]()
//            categoryArr.append(try await gameService.fetchFinalJeopardy() ?? JCategory(title: "", id: 0, clues: []))
//            self.categories = categoryArr
//        }
//    }
    
}

enum GameState {
    case start
    case finishedJeopardy
    case finishDoubleJeopardy
    case finishedFinalJeopardy

}

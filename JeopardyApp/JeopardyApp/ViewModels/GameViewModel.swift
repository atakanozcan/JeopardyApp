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
    public var model: GameModel
    private var gameService: GameService
    
    init(_ model: GameModel, gameService: GameService = GameService()) {
        self.model = model
        self.gameService = gameService
    }
    
    public var currentCash: String {
        model.currentCash.description
    }
    
    public var gameState: GameState {
        if model.finishedFinalJeopardy {
            return .finishedFinalJeopardy
        } else if model.isDoubleJeopardyFinished() {
            return .finishedDoubleJeopardy
        } else if model.isJeopardyFinished() {
            return .finishedJeopardy
        } else {
            return .start
        }
    }
    
    @MainActor
    public func onAppear() {
        self.getGame()
    }
    
    @MainActor
    func getGame() {
        Task {
            let newModel = try await self.gameService.fetchANewGame()
            model.save(newModel)
        }
    }
    
    @MainActor
    public func restartGame() {
        self.getGame()
    }
    
}

enum GameState {
    case start
    case finishedJeopardy
    case finishedDoubleJeopardy
    case finishedFinalJeopardy

}

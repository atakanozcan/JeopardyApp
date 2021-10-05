import Foundation
import Combine

public class GameModel: ObservableObject {

    @Published public internal(set) var currentCash: Int
    @Published public var jeopardy: [JCategory]
    @Published public var doubleJeopardy: [JCategory]
    @Published public internal(set) var finalJeopardy: JCategory
    @Published public internal(set) var answeredClues = [Clue]()
    @Published public internal(set) var finishedFinalJeopardy: Bool = false

    init(currentCash: Int, jeopardy: [JCategory], doubleJeopardy: [JCategory], finalJeopardy: JCategory) {
        self.currentCash = currentCash
        self.jeopardy = jeopardy
        self.doubleJeopardy = doubleJeopardy
        self.finalJeopardy = finalJeopardy
    }

    public func category(_ id: JCategory.ID?) -> JCategory? {
        var categories = jeopardy + doubleJeopardy
        categories.append(finalJeopardy)
        return categories.first(where: { $0.id == id })
    }
    
    public func categories(isDoubleJeopardy: Bool) -> [JCategory] {
        return isDoubleJeopardy ? doubleJeopardy : jeopardy
    }
    
    public func clue(categoryId: JCategory.ID, clueId: Clue.ID?) -> Clue? {
        return category(categoryId)?.clues.first(where: { $0.id == clueId })
    }
        
    public func answer(categoryId: JCategory.ID, clueId: Clue.ID?, answer: String) {
        objectWillChange.send()
        if let clue = clue(categoryId: categoryId, clueId: clueId) {
            answeredClues.append(clue)
            if answer.caseInsensitiveCompare(clue.answer) == .orderedSame {
                currentCash += clue.difficulty
            } else {
                currentCash -= clue.difficulty
            }
        }
    }
    
    public func answerFinalJeopardy(answer: String, bet: Int) {
        objectWillChange.send()
        if answer.caseInsensitiveCompare(finalJeopardy.clues.first?.answer ?? answer) == .orderedSame {
            currentCash += bet
        } else {
            currentCash -= bet
        }
        finishedFinalJeopardy = true
    }
    
    public func isAnswered(categoryId: JCategory.ID, clueId: Clue.ID) -> Bool {
        if let clue = clue(categoryId: categoryId, clueId: clueId) {
            return answeredClues.contains(where: { $0.id == clue.id })
        } else { return false }
    }
    
    public func remainingAmountsForCategory(cstegoryId: JCategory.ID) -> [Int] {
        var remainingAmts = [Int]()
        for clue in category(cstegoryId)?.clues ?? [] {
            if !answeredClues.contains(where: { $0.id == clue.id }) {
                remainingAmts.append(clue.difficulty)
            }
        }
        return remainingAmts
    }
    
    public func isCategoryFinished(categoryId: JCategory.ID) -> Bool {
        var finished = true
        for clue in category(categoryId)?.clues ?? [] {
            if !isAnswered(categoryId: categoryId, clueId: clue.id) {
                finished = false
            }
        }
        return finished
    }
    
    public func isJeopardyFinished() -> Bool {
        var finished = true
        for category in jeopardy {
            if !isCategoryFinished(categoryId: category.id) {
                finished = false
            }
        }
        return finished
    }
    
    public func isDoubleJeopardyFinished() -> Bool {
        var finished = true
        for category in doubleJeopardy {
            if !isCategoryFinished(categoryId: category.id) {
                finished = false
            }
        }
        return finished
    }
}

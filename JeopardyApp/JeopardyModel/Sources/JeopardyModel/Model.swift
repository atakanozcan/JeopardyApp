import Foundation
import Combine

public class Model: ObservableObject {

    @Published public internal(set) var currentCash: Int
    @Published public var jeopardy: [Category]
    @Published public var doubleJeopardy: [Category]
    @Published public internal(set) var finalJeopardy: Clue
    
    @Published public internal(set) var answeredClues = [Clue]()

    init(currentCash: Int, jeopardy: [Category], doubleJeopardy: [Category], finalJeopardy: Clue) {
        self.currentCash = currentCash
        self.jeopardy = jeopardy
        self.doubleJeopardy = doubleJeopardy
        self.finalJeopardy = finalJeopardy
    }

    public func category(_ id: Category.ID?) -> Category? {
        return (jeopardy + doubleJeopardy).first(where: { $0.id == id })
    }
    
    public func categories(isDoubleJeopardy: Bool) -> [Category] {
        return isDoubleJeopardy ? doubleJeopardy : jeopardy
    }
    
    public func clue(categoryId: Category.ID, clueId: Clue.ID?) -> Clue? {
        return category(categoryId)?.clues.first(where: { $0.id == clueId })
    }
        
    public func answer(categoryId: Category.ID, clueId: Clue.ID?, answer: String) {
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
    
    public func isAnswered(categoryId: Category.ID, clueId: Clue.ID) -> Bool {
        if let clue = clue(categoryId: categoryId, clueId: clueId) {
            return answeredClues.contains(where: { $0.id == clue.id })
        } else { return false }
    }
    
    public func remainingAmountsForCategory(cstegoryId: Category.ID) -> [Int] {
        var remainingAmts = [Int]()
        for clue in category(cstegoryId)?.clues ?? [] {
            if !answeredClues.contains(where: { $0.id == clue.id }) {
                remainingAmts.append(clue.difficulty)
            }
        }
        return remainingAmts
    }
}

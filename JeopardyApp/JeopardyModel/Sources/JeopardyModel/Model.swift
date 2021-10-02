import Foundation
import Combine

public class Model: ObservableObject {

    @Published public internal(set) var currentCash: Int
    @Published public internal(set) var jeopardy: [Category]
    @Published public internal(set) var doubleJeopardy: [Category]
    @Published public internal(set) var finalJeopardy: Clue

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
}

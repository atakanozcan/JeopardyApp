import Foundation
import Combine

public class Model: ObservableObject {

    @Published public internal(set) var clue1: Clue?
    @Published public internal(set) var clue2: Clue?
    @Published public internal(set) var clue3: Clue?
    @Published public internal(set) var clue4: Clue?
    @Published public internal(set) var clue5: Clue?
    @Published public internal(set) var category1: Category?
    

    init(clue1: Clue? = nil, clue2: Clue? = nil, clue3: Clue? = nil, clue4: Clue? = nil, clue5: Clue? = nil, category: Category? = nil) {
        self.clue1 = clue1
        self.clue2 = clue2
        self.clue3 = clue3
        self.clue4 = clue4
        self.clue5 = clue5
        self.category1 = category
    }
}

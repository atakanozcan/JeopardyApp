//
//  GameService.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 4.10.2021.
//

import Foundation
import Combine
import JeopardyModel
//TODO: Add appropriate network errors

final class GameService {
    
    func fetchCategoriesWithClues(isDoubleJeopardy: Bool) async throws -> [JCategory] {
        let categories = try await self.fetchCategories()
        var categoriesToReturn = [JCategory]()
        
        try await withThrowingTaskGroup(of: (JCategory,[Clue]).self) { group in
            for category in categories {
                group.addTask {
                    let clues = try await self.fetchCluesForCategory(category.id.description, isDoubleJeopardy: isDoubleJeopardy)
                    return (category, clues)
                }
                for try await pair in group {
                    categoriesToReturn.append(JCategory(title: pair.0.title, id: pair.0.id, clues: pair.1))
                }
            }
        }
    
        return categoriesToReturn
        
    }
    
    private func fetchCategories() async throws -> [JCategory] {
        let sixRandomClues = try await self.fetchSixRandomClues()
        var categoriesToReturn = [JCategory]()
        
        try await withThrowingTaskGroup(of: JCategory.self) { group in
            for clue in sixRandomClues {
                group.addTask {
                    let category = try await self.fetchCategory(clue.categoryId.description)
                    return category
                }
                for try await category in group {
                    categoriesToReturn.append(category)
                }
            }
        }
        return categoriesToReturn
    }
    
    private func fetchSixRandomClues() async throws -> [Clue] {
        let endpoint = Endpoint.sixRandomClues
        let urlRequest = URLRequest(url: endpoint.url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GameServiceError.badID
        }
        
        do {
            let clues = try JSONDecoder().decode([Clue].self, from: data)
            return clues
        } catch {
            print("JSON decoding error: \(error)")
            return []
        }
        
    }
    
    private func fetchCategory(_ id: String) async throws -> JCategory {
        let endpoint = Endpoint.category(id)
        let urlRequest = URLRequest(url: endpoint.url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GameServiceError.badID
        }
    
        let category = try JSONDecoder().decode(JCategory.self, from: data)
        
        return category
     
    }
    
    private func fetchCluesForCategory(_ id: String, isDoubleJeopardy: Bool) async throws -> [Clue] {
        let endpoint = Endpoint.cluesForCategory(id)
        let urlRequest = URLRequest(url: endpoint.url)
        var cluesWithDifficulties = [Clue]()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GameServiceError.badID
        }
        
        do {
            let clues = try JSONDecoder().decode([Clue].self, from: data)
            for i in 0..<clues.count {
                cluesWithDifficulties.append(Clue(id: clues[i].id, difficulty: isDoubleJeopardy ? (i+1)*400 : (i+1)*200, categoryId: clues[i].categoryId, question: clues[i].question, answer: clues[i].answer))
            }
            return cluesWithDifficulties
        } catch {
            print("JSON decoding error: \(error)")
            throw GameServiceError.badData
        }
    }
    
    func fetchFinalJeopardy() async throws -> JCategory {
        var cancellable = Set<AnyCancellable>()
        
        do {
            let clue = try await fetchFinalJeopardyClue().awaitSink(cancellable: &cancellable)
            let category = try await fetchCategory(clue.categoryId.description)
            return JCategory(title: category.title, id: category.id, clues: [clue])
        } catch {
          print("An error occured while fetching final jeopardy: \(error)")
            throw GameServiceError.badData
        }
    }
    
    private func fetchFinalJeopardyClue() -> AnyPublisher<Clue, Error> {
        let url = Endpoint.randomClue.url
        print(url)
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                print(element.data)
                return element.data
                }
            .decode(type: [Clue].self, decoder: JSONDecoder())
            .map { $0.first ?? Clue(id: 0, difficulty: 0, categoryId: 0, question: "", answer: "") }
            .eraseToAnyPublisher()
    }
}

//Extension for combining async/await and Combine
//ref: https://philipp307.medium.com/using-async-await-in-combine-978e9497466

extension Publisher {

    func awaitSink(cancellable: inout Set<AnyCancellable>) async throws -> Output {

            return try await withCheckedThrowingContinuation { continuation in

                self.sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(with: .failure(error))
                    }

                } receiveValue: { result in
                    continuation.resume(with: .success(result))
                }
                .store(in: &cancellable)
            }
    }
}

enum GameServiceError: Error {
    case invalidURL
    case badID
    case badData
}


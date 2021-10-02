//
//  QuestionView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

//import SwiftUI
//import JeopardyModel
//
//struct QuestionView: View {
//    var model: JeopardyModel.Model
//    @Binding var text: String
//    
//    var body: some View {
//        VStack {
//            
//            ClueCell(clue: model.finalJeopardy, state: .clue)
//
//            TextField("What is?", text: $text)
//        }
//    }
//}
//
//struct QuestionView_Previews: PreviewProvider {
//    private static let model:Model = MockModel()
//    @Published var text: String
//    static var previews: some View {
//        QuestionView(model: model, text: $text)
//    }
//}

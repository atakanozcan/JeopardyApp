//
//  QuestionView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

import SwiftUI
import JeopardyModel

struct QuestionView: View {
    var clue: JeopardyModel.Clue
    @State var text: String = ""
    @ObservedObject private var viewModel: CluesGridViewModel

    
    init(_ clue: JeopardyModel.Clue, viewModel: CluesGridViewModel) {
        self.clue = clue
        self.viewModel = viewModel
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color("JeopardyDarkBlue")
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                ClueCell(clue: clue, state: .clue)
                                
                Spacer()
                
                VStack{
                    HStack {
                        TextEditor(text: $text)
                            .placeholder(when: text.isEmpty) {
                                Text("What is...").foregroundColor(Color("JeopardySecondaryColor")).padding()
                                
                            }
                            .foregroundColor(Color.white)
                            .padding(10)
                            .frame(width: 250, height: 100, alignment: .center)
                        
                        
                        Image(systemName: "questionmark.square.fill")
                            .foregroundColor(Color("JeopardySecondaryColor"))
                            .padding(12)

                    }
                    .background(
                        RoundedRectangle(cornerRadius: 2).fill(Color("JeopardyColor"))).border(Color.black, width: 3)
                        .padding(20)
                    
                    Button("Submit") {
                        viewModel.answer(clueId: clue.id)
                    }.foregroundColor(Color("JeopardySecondaryBlue"))
                    
                }
                
                Spacer()
            }
        }
    }
}

// For adding placeholder color to TextEditor https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct QuestionView_Previews: PreviewProvider {
    private static let model:Model = MockModel()
    static var previews: some View {
        QuestionView(model.jeopardy.first?.clues.first ?? Clue(id: 0, difficulty: 0, category: "", question: "", answer: "", answered: false) , viewModel: CluesGridViewModel(model, categoryId: model.jeopardy.first?.id ?? 0))
    }
}

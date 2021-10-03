//
//  QuestionView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 1.10.2021.
//

import SwiftUI
import JeopardyModel

struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject private var viewModel: CluesGridViewModel
    var clueIdx: Int
    @State var text: String = ""

    init(viewModel: CluesGridViewModel, clueIdx: Int) {
        self.viewModel = viewModel
        self.clueIdx = clueIdx
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color("JeopardyDarkBlue")
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                ClueCell(viewModel: self.viewModel, idx: self.clueIdx, state: .clue)
                                
                Spacer()
                
                VStack{
                    HStack {
                        TextEditor(text: $text)
                            .placeholder(when: text.isEmpty) {
                                Text("What is...").foregroundColor(Color("JeopardySecondaryColor")).padding(10)
                                
                            }
                            .foregroundColor(Color.white)
                            .padding(10)
                            .frame(width: 250, height: 100, alignment: .center)
                        
                        
                        Image(systemName: "questionmark.square.fill")
                            .foregroundColor(Color("JeopardySecondaryColor"))
                            .padding(10).font(.system(size: 25))
                            .frame(alignment: .topTrailing)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 2).fill(Color("JeopardyColor"))).border(Color.black, width: 3)
                        .padding(20)
                    
                    Button("Submit") {
                        viewModel.answer(clueIdx, text)
                        presentationMode.wrappedValue.dismiss()
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
        alignment: Alignment = .topLeading,
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
        QuestionView(viewModel: CluesGridViewModel(model, model.jeopardy.first?.id ?? 0), clueIdx: 0)
    }
}

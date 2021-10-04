//
//  FinalJeopardyView.swift
//  JeopardyApp
//
//  Created by Atakan Özcan on 4.10.2021.
//

import SwiftUI
import JeopardyModel
import Combine

struct FinalJeopardyView: View {
    @ObservedObject var viewModel: FinalJeopardyViewModel
    @EnvironmentObject var model: GameModel
    @State private var totalBet = "0"
    @State private var openQuestion: Bool = false
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        //https://stackoverflow.com/questions/58733003/swiftui-how-to-create-textfield-that-only-accepts-numbers
        VStack{
            Text(viewModel.categoryTitle)
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 360, height: 200)
                .background(
                    Rectangle().fill(Color("JeopardyColor"))).border(Color.black, width: 3)
            
            HStack {
                Image(systemName: "dollarsign.square.fill")
                    .foregroundColor(.white)
                    .padding(10).font(.system(size: 25))
                    .frame(alignment: .topTrailing)
                
                TextField("Betted amount", text: $totalBet)
                         .keyboardType(.numberPad)
                         .onReceive(Just(totalBet)) { newValue in
                             var filtered = newValue.filter { "0123456789".contains($0) }
                             if Int(filtered) ?? 0 >= viewModel.currentCash {
                                 filtered = viewModel.currentCash.description
                             }
                             if filtered != newValue {
                                 self.totalBet = filtered
                             }
                         }
                    .foregroundColor(Color.white)
                    .padding(10)
                    .frame(width: 250, height: 100, alignment: .center)
            }
            .background(
                RoundedRectangle(cornerRadius: 2).fill(Color("JeopardyColor"))).border(Color.black, width: 3)
                .padding(20)
            Button("Submit Bet") {
                openQuestion.toggle()
            }
        }.sheet(isPresented: $openQuestion, onDismiss: { presentationMode.wrappedValue.dismiss() }) {
            QuestionView(viewModel: QuestionViewModel(model, categoryId: viewModel.clue.categoryId, clueId: viewModel.clue.id, finalBet: Int(totalBet)))
        }
    }
}

struct FinalJeopardyView_Previews: PreviewProvider {
    private static let model:GameModel = MockModel()
    static var previews: some View {
        FinalJeopardyView(viewModel: FinalJeopardyViewModel(model)).environmentObject(model)
    }
}

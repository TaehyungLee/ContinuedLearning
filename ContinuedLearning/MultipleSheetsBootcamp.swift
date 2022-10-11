//
//  MultipleSheetsBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/09.
//

import SwiftUI

struct RandomModel:Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 : use a Binding
// 2 : use multiple .sheets
// 3 : use $items   --> very useful

struct MultipleSheetsBootcamp: View {
    
//    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var selectedModel: RandomModel? = nil
//    @State var showSheet:Bool = false
//    @State var showSheet2:Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
        }
        /*
        VStack(spacing:20) {
            
            
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            }
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
//                showSheet.toggle()
//                showSheet2.toggle()
            }
//            .sheet(isPresented: $showSheet2) {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            }
             
        }
         */
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
        
        
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: $selectedModel)
//            NextScreen(selectedModel: selectedModel)
//
//        }
        
    }
}

struct NextScreen:View {
    
//    @Binding var selectedModel: RandomModel
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}

//
//  ProgressViewBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/11/07.
//

import SwiftUI

public struct CircularProgressViewStyle: ProgressViewStyle {
    var size: CGFloat
    private let lineWidth: CGFloat = 20
    private let defaultProgress = 0.0
    private let gradient = LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
    public func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
        ZStack {
            configuration.label
            progressCircleView(fractionCompleted: configuration.fractionCompleted ?? defaultProgress)
            configuration.currentValueLabel
            
        }
        
    }
    
    private func progressCircleView(fractionCompleted: Double) -> some View {
        Circle()
            .stroke(gradient, lineWidth: lineWidth)
            .opacity(0.2)
            .overlay(progressFill(fractionCompleted: fractionCompleted))
            .frame(width: size, height: size)
        
    }
    
    private func progressFill(fractionCompleted: Double) -> some View {
        Circle()
        .trim(from: 0, to: CGFloat(fractionCompleted))
        .stroke(gradient, lineWidth: lineWidth)
        .frame(width: size)
        .rotationEffect(.degrees(-90))
        
    }
    
}

class ProgressViewModel:ObservableObject {
    @Published var progress:Double = 0
    var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    init() {
        
    }
}

struct ProgressViewBootcamp: View {
    
    @StateObject var vm = ProgressViewModel()
    var body: some View {
        VStack {
            Button("Start") {
                
            }
            ProgressView("\(Int(vm.progress))%", value: vm.progress, total: 100)
                .padding()
                .progressViewStyle(CircularProgressViewStyle(size: 80))
            
        }
        .onReceive(vm.timer) { value in
            withAnimation {
                vm.progress = vm.progress == 100 ? 0 : vm.progress + 5
            }
        }
        
    }
}

struct ProgressViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewBootcamp()
    }
}

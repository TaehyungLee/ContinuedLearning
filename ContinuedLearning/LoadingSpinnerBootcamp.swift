//
//  LoadingSpinnerBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/11/07.
//

import SwiftUI

struct LoadingSpinnerView: View {
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var spinnerSize:CGSize
    
    init(isCircleRotating: Bool = true, animateStart: Bool = false, animateEnd: Bool = true, spinnerSize: CGSize = CGSize(width: 80, height: 80)) {
        self.isCircleRotating = isCircleRotating
        self.animateStart = animateStart
        self.animateEnd = animateEnd
        self.spinnerSize = spinnerSize
    }
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .fill(Color.init(red: 0.96, green: 0.96, blue: 0.96))
                .frame(width: spinnerSize.width, height: spinnerSize.height)
            
            Circle()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                .stroke(lineWidth: 10)
                .rotationEffect(.degrees(isCircleRotating ? 360 : 0))
                .frame(width: spinnerSize.width, height: spinnerSize.height)
                .foregroundColor(Color.blue)
                .onAppear() {
                    withAnimation(Animation
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false)) {
                            self.isCircleRotating.toggle()
                        }
                    withAnimation(Animation
                        .linear(duration: 1)
                        .delay(0.5)
                        .repeatForever(autoreverses: true)) {
                            self.animateStart.toggle()
                        }
                    withAnimation(Animation
                        .linear(duration: 1)
                        .delay(1)
                        .repeatForever(autoreverses: true)) {
                            self.animateEnd.toggle()
                        }
                }
        }
    }
}

struct LoadingSpinnerBootcamp: View {
    var body: some View {
        ZStack {
            LoadingSpinnerView(spinnerSize: CGSize(width: 70, height: 70))
        }
    }
}

struct LoadingSpinnerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinnerBootcamp()
    }
}

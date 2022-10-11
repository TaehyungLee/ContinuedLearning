//
//  MagnificationGestureView.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/09.
//

import SwiftUI

struct MagnificationGestureView: View {
    
    @State var currentAmount:CGFloat = 0
    @State var lastAmount:CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftui Aswome")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo!")
        }

    }
}

struct MagnificationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureView()
    }
}

//
//  ToastBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/11/02.
//

import SwiftUI
import Combine
struct Toast {
    var title:String
    var image:String
}

struct ToastView: View {
    let toast:Toast
    
    @Binding var show:Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: toast.image)
                Text(toast.title)
            }
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .background(.gray.opacity(0.4), in: Capsule())
        }
        .frame(width: UIScreen.main.bounds.width / 1.25)
        .transition(AnyTransition.move(edge: .bottom).combined(with:.opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.show = false
                }
            }
        }
    }
}

struct Overlay<T:View>:ViewModifier {
    @Binding var show:Bool
    let overlayView:T
    func body(content:Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}

extension View {
    func overlay<T:View>(overlayView:T, show:Binding<Bool>) -> some View {
        self.modifier(Overlay(show: show, overlayView: overlayView))
    }
}

struct ToastBootcamp: View {
    
    @State var showToast = false
    
    var body: some View {
        
        ZStack {
            Button {
                showToast.toggle()
            } label: {
                Text("Toast")
            }
        }
        .overlay(overlayView: ToastView(toast: Toast(title: "Text Long Text Long Text Long Text Long Text Long Text Long Text Long Delete!!", image: "trash"),
                                        show: $showToast),
                 show: $showToast)
        
    }
}

struct ToastBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToastBootcamp()
    }
}

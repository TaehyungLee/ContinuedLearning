//
//  ProgressViewBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/11/07.
//

import SwiftUI

class ProgressViewModel:ObservableObject {
    @Published var progress:Double = 0
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    init() {
        
    }
}

struct ProgressViewBootcamp: View {
    
    @StateObject var vm = ProgressViewModel()
    var body: some View {
        VStack {
            Button("Start") {
                
            }
            ProgressView("Loading...", value: vm.progress, total: 100)
                .padding()
        }
        .onReceive(vm.timer) { value in
            withAnimation {
                vm.progress = vm.progress == 100 ? 0 : vm.progress + 1
            }
        }
        
    }
}

struct ProgressViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewBootcamp()
    }
}

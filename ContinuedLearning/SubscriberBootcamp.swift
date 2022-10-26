//
//  SubscriberBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/25.
//

import SwiftUI
import Combine

class SubscriberViewModel:ObservableObject {
    @Published var count:Int = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText:String = ""
    @Published var textValid:Bool = false
    
    @Published var showButton = false
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)    // 0.5초 후에 아래 코드를 실행
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textValid, on: self)    assign을 가능하면 쓰지않고 sink를 사용하는게 좋다
            .sink(receiveValue: { [weak self] isValid in
                self?.textValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] value in
                
                guard let self = self else { return }
                self.count += 1
                
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textValid
            .combineLatest($count)      // 두 publisher를 결합
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                }else{
                    self.showButton = false
                }
            }.store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            TextField("Type Something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .background(Color.init(white: 0.89))
                .cornerRadius(10)
                .overlay (
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textValid ? 0.0: 1.0
                            )
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(
                                vm.textValid ? 1.0: 0.0
                            )
                    }
                    .font(.title)
                    .padding(.trailing)
                    , alignment: .trailing
                )
        
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(
                        vm.showButton ? 1.0: 0.5
                    )
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}

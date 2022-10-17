//
//  WeakSelfBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/17.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count:Int?
    
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
                    
            }.navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
                
        )
    }
}

class WeakSelfSecondScreenViewModel:ObservableObject {
    @Published var data:String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCnt = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCnt + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCnt = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCnt - 1, forKey: "count")
        
    }
    
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+500) { [weak self] in
            // 클로저 안에 self를 참조하고있으면 클로저를 수행하기위한 reference count가 +1 더 증가됨
            // weak self를 하지 않으면 view model이 해제되더라도 이 클로저는 살아있기때문에 메모리 릭이 발생
            self?.data = "NEW DATA!!"
        }
        
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm:WeakSelfSecondScreenViewModel = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}

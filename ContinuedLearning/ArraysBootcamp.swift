//
//  ArraysBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/11.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name:String
    let point:Int
    let isVerified:Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray:[UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray:[String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        // sort
        /*
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.point < user2.point
//        }
//        filteredArray = dataArray.sorted(by: { $0.point < $1.point })
        */
        
        // filter
        /*
//        filteredArray = dataArray.filter({ (user)->Bool in
//            return user.isVerified
//        })
        filteredArray = dataArray.filter({ $0.isVerified })
         */
        
        // map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
//        mappedArray = dataArray.map({ $0.name })
//        mappedArray = dataArray.compactMap({ $0.name })
        */
        
        mappedArray = dataArray.sorted(by: { $0.point > $1.point })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", point: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", point: 0, isVerified: false)
        let user3 = UserModel(name: "Joe", point: 20, isVerified: true)
        let user4 = UserModel(name: "Emily", point: 50, isVerified: false)
        let user5 = UserModel(name: "Samantha", point: 45, isVerified: true)
        let user6 = UserModel(name: "Jason", point: 23, isVerified: false)
        let user7 = UserModel(name: "Sarah", point: 76, isVerified: true)
        let user8 = UserModel(name: "Lisa", point: 45, isVerified: false)
        let user9 = UserModel(name: "Steve", point: 1, isVerified: true)
        let user10 = UserModel(name: "Amanda", point: 100, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                
                ForEach(vm.mappedArray, id:\.self) { name in
                    Text(name)
                        .font(.headline)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.point)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}

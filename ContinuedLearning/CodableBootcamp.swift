//
//  CodableBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/17.
//

import SwiftUI

// Codable = Decodable + Encodable
struct CustomerModel:Codable, Identifiable {
    let id:String
    let name:String
    let points:Int
    let isPremium:Bool
    
    // Codable 하면 자동으로 적용
    /*
    // codingkey는 모델의 변수명과 같아야함
    enum CodingKeys: CodingKey {
        case id
        case name
        case points
        case isPremium
//        case isPremium = "is_premium"     // 실제 key와 모델의 이름이 다를경우 처리 방법
    }
    
    init(id:String, name:String, points:Int, isPremium:Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
        
    }
     */
}

class CodableViewModel:ObservableObject {
//    @Published var customer = CustomerModel(id: "1", name: "Nick", points: 5, isPremium: false)
    @Published var customer:CustomerModel? = nil
    
    init() {
        getData()
    }
    
    deinit {
        
    }
    
    func getData() {
        
        guard let data = getJSONData() else { return }
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("Error decoding : \(error.localizedDescription)")
//        }
        
//        if let localData = try? JSONSerialization.data(withJSONObject: data, options: []),
//           let dictionary = localData as? [String:Any] {
//            let id = dictionary["id"] as? String
//            let name = dictionary["name"] as? String
//            let points = dictionary["points"] as? Int
//            let isPremium = dictionary["isPremium"] as? Bool
//
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//
//        }
            
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "1211", name: "Poul", points: 77, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary:[String:Any] = [
//            "id":"12345",
//            "name":"joe",
//            "points":5,
//            "isPremium":true
//
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    var body: some View {
        VStack {
            Text(vm.customer?.id ?? "")
            Text(vm.customer?.name ?? "")
            Text("\(vm.customer?.points ?? 0)")
            Text(vm.customer?.isPremium ?? false ? "True":"False")
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}

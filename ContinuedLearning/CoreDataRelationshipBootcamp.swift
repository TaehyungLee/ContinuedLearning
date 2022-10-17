//
//  CoreDataRelationshipBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/12.
//

import SwiftUI

class CoreDataManager {
    static let instance = CoreDataManager()
    
}

class CoreDataRelationshipBootcampViewModel:ObservableObject {
    
}

struct CoreDataRelationshipBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoreDataRelationshipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootcamp()
    }
}

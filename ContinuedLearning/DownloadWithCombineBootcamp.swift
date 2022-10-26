//
//  DownloadWithCombineBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/25.
//

import SwiftUI
import Combine

struct PostModel:Identifiable, Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

class DownloadWithCombineViewModel:ObservableObject {
    @Published var posts:[PostModel] = []
    var cancellables = Set<AnyCancellable>()
    init() {
        getPosts()
    }
    
    func getPosts() {
        
//        let urlStr = "https://jsonplaceholder.typicode.com/posts/1"
        let urlStr = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: urlStr) else { return }
        
        /*
         1. 매달 집으로 배달되는 패키지에 가입함
         2. 회사가 뒤에서 구독자들에게 배달될 패키지를 만들어 공장이 지속되도록 함
         3. 당신은 그것을 현관문 앞에서 페키지를 받게 될 것
         4. 문제없는지 상자를 확인
         5. 상자를 열어서 품목이 맞는지 확인
         6. 품목을 사용
         7. 언제든지 취소가능
        */
        
        // create publisher
        // subscribe publisher on background thread
        // recieve on main thread
        // trymap( check that the data is good ) 데이터가 양호한지 확인
        // decode( decode data into postmodels)
        // sink (put the item into our app)
        // store(cancel subscription)
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background)) // defaul : main thread
            .receive(on: DispatchQueue.main)
            .tryMap ( handleOutput )
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }.store(in: &cancellables)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineBootcamp: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment:.leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
            }
        }.listStyle(.plain)
    }
}

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}

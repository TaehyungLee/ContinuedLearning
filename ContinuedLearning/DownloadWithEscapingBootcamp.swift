//
//  DownloadWithEscapingBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/17.
//

import SwiftUI

struct PostModel:Identifiable, Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

class DownloadWithEscapingViewModel:ObservableObject {
    
    @Published var posts:[PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
//        let urlStr = "https://jsonplaceholder.typicode.com/posts/1"
        let urlStr = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: urlStr) else { return }
        
        downloadData(fromURL: url) { returnedData in
            guard let data = returnedData else {
                print("No data returned")
                return
            }
            
            guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {
                return
            }

            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
                self?.posts = newPosts
            }
            
        }
    }
    
    func downloadData(fromURL url:URL, completionHandler: @escaping (_ data:Data?) -> ()) {
        
        
        // URLSession.shared.dataTask는 자동으로 background thread에서 동작
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error Downloading data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
            
            
            
        }.resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
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

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}

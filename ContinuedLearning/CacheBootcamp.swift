//
//  CacheBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/26.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    private init() {}
    
    var imageCache:NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        // 재한을 두는게 효율적
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image:UIImage, name:String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "added to cache!"
    }
    
    func remove(name:String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "remove from cache!"
    }
    
    func getCache(name:String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel:ObservableObject {
    @Published var startingImage:UIImage? = nil
    @Published var cachedImage:UIImage? = nil
    
    @Published var infoMessage:String = ""
    
    let manager = CacheManager.instance
    let imageName:String = "steve"
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.getCache(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
        
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let img = vm.startingImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Remove from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }

                if let img = vm.cachedImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct ChacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}

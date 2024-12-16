//
//  DownloadWithCombine.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 16/12/24.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancelable = Set<AnyCancellable>()
    
    init() {
        getPost()
    }
    
    func getPost() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // MARK: - example combine on RL
        // 1. sign up for monthly subcription package to be delivered
        // 2. the company would make the package behind the scene
        // 3. receive the package at your front door
        // 4. make sure the box isn't broken
        // 5. open and make sure the item is correct
        // 6. use the item!!!
        // 7. cancellable at any time
        
        // MARK: - example combine on URLSession
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. receive data on main thread
        // 4. tryMap data(check data is good or not)
        // 5. decode data to PostModel
        // 6. sink (put the item into our app)
        // 7. store (cancel subcription if we need)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancelable)
        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode <= 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadWithCombineView: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.subheadline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadWithCombineView()
}

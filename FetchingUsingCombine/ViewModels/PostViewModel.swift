//
//  PostViewModel.swift
//  FetchingUsingCombine
//
//  Created by test on 06/02/25.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []  // Emits updates to the View

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchPosts()
    }

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fetchedPosts in
                self?.posts = fetchedPosts  // Updates the published property
            })
            .store(in: &cancellables)  // Stores the subscription
    }
}

//
//  FilmViewModel.swift
//  FetchingUsingCombine
//
//  Created by test on 06/02/25.
//
import Foundation
import Combine


class FilmViewModel: ObservableObject {
    @Published var films: [Film] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getFilms()
    }
    
    
    func getFilms() {
        
        guard let url = URL(string: "https://swapi.dev/api/films/") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Films.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error Downloading Data: \(error)")
                case .finished:         // data stream is ended and left no data to download (fetch)
                    break
                }
            }, receiveValue: { [weak self] fetchedData in
                self?.films = fetchedData.results
            })
            .store(in: &cancellables)
    }
}


/*
import Foundation
import Combine

class FilmViewModel: ObservableObject {
    @Published var films: [Film] = []  // Emits updates to the View

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFilms()
    }

    func fetchFilms() {
        guard let url = URL(string: "https://swapi.dev/api/films/") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Films.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fetchedFilms in
                self?.films = fetchedFilms.results  // Updates the published property
            })
            .store(in: &cancellables)  // Stores the subscription
        // it is used to prevenent the request from being automatically cancelled when this function finished.
    }
}


// [weak self] -> It is used to prevent memory leak, because when a property(variable) holds strong reference that they never get deallocated from memory, even whey you are done using them, which can cause app to use more memory than necessary
*/

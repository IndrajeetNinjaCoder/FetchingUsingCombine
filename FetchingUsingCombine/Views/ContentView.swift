//
//  ContentView.swift
//  FetchingUsingCombine
//
//  Created by test on 06/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var filmVM = FilmViewModel()
    
    var body: some View {
       
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea()
            
            if filmVM.films.isEmpty {
                ProgressView("Loading...")
            } else {
                TabView {
                    ForEach(filmVM.films) { film in
                        FilmDetailView(film: film)
                            
                    }
                }
                .accentColor(.blue)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Enables swipe-based tab navigation
                .navigationTitle("Films")
            }
        }
    }
}


struct FilmDetailView: View {
    let film: Film

    func replace(text: String) -> String {
        return text.replacingOccurrences(of: "\r\n", with: " ")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(film.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)

                Text("Director: \(film.director)")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text("Producer: \(film.producer)")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text("Opening Crawl")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                Text(replace(text: film.openingCrawl))
                    .font(.body)

                Divider()

                Text("Release Date")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                Text(film.releaseDate)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}



#Preview {
    ContentView()
}

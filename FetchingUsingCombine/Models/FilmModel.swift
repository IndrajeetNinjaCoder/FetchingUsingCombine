//
//  FilmModel.swift
//  FetchingUsingCombine
//
//  Created by test on 06/02/25.
//

import Foundation

struct Films: Codable {
    let results: [Film]
}

struct Film: Identifiable, Codable {
    let id: UUID = UUID()
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
    }
}

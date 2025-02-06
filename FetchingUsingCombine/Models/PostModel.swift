//
//  PostModel.swift
//  FetchingUsingCombine
//
//  Created by test on 06/02/25.
//

import Foundation


struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}



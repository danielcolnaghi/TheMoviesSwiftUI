//
//  NetworkResponse.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 20/02/2024.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct MovieResponse: Codable {
    let dates: Dates?
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

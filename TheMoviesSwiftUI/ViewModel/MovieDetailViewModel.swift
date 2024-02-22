//
//  MovieDetailViewModel.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 21/02/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var genres: [String]
    
    init(movie: Movie, genres: [String] = []) {
        self.movie = movie
        self.genres = genres
    }
    
    func loadData() {
        NetworkSession.shared.getGenreMovieList { result in
            if let result = result {
                self.genres = result.genres.filter { genre in
                    return self.movie.genreIds.contains(genre.id)
                }.map({ $0.name })
            }
        }
    }
}

//
//  MoviesViewModel.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 19/02/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    enum MovieType { case nowPlaying, popular, topRated, upcoming }
    
    var movieType: MovieType = .nowPlaying
    @Published var movies: [Movie] = [Movie]()
    
    init(movieType: MovieType, movies: [Movie] = [Movie]()) {
        self.movieType = movieType
        self.movies = movies
    }
    
    func loadMovies() {
        switch movieType {
        case .nowPlaying:
            NetworkSession.shared.getNowPlayingMovieList { result in
                self.updateMovies(result)
            }
        case .popular:
            NetworkSession.shared.getPopularMovieList { result in
                self.updateMovies(result)
            }
        case .topRated:
            NetworkSession.shared.getTopRatedMovieList { result in
                self.updateMovies(result)
            }
        case .upcoming:
            NetworkSession.shared.getUpcomingMovieList { result in
                self.updateMovies(result)
            }
        }
    }
    
    private func updateMovies(_ result: MovieResponse?) {
        DispatchQueue.main.async {
            if let result = result {
                self.movies = result.movies
            }
        }
    }
    
    var titleForType: String {
        switch movieType {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

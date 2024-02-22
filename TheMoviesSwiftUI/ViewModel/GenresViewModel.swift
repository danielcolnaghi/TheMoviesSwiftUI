//
//  GenresViewModel.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 19/02/2024.
//

import Foundation

class GenresViewModel: ObservableObject {
    @Published var genres: [Genre] = [Genre]()
    
    func loadData() {
        NetworkSession.shared.getGenreMovieList { result in
            if let result = result {
                DispatchQueue.main.async {
                    self.genres = result.genres
                }
            }
        }
    }
}

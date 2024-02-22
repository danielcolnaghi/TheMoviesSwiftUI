//
//  MoviesView.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 20/02/2024.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    @ObservedObject var genreViewModel: GenresViewModel = GenresViewModel()
    
    var body: some View {
        NavigationView {
            List(moviesViewModel.movies, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(viewModel: MovieDetailsViewModel(movie: movie))) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text("Release Date: \(movie.releaseDate)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(format: "%.1f", movie.voteAverage))
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
            .navigationTitle(moviesViewModel.titleForType)
            .onAppear {
                moviesViewModel.loadMovies()
                genreViewModel.loadData()
            }
        }
    }
}

struct MovieDetail: View {
    var movie: Movie

    var body: some View {
        // You can display more details about the movie here
        Text(movie.overview)
            .padding()
            .navigationTitle(movie.title)
    }
}


struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(moviesViewModel: MoviesViewModel(movieType: .nowPlaying))
    }
}

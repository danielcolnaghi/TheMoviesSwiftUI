//
//  MovieDetailView.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 20/02/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ScrollView {
            Text(viewModel.movie.overview)
                .font(.subheadline)
            
            RemoteImage(url: URL(string: "https://www.themoviedb.org/t/p/w1280\(viewModel.movie.backdropPath ?? "")"))
                .cornerRadius(12)
            
            VStack {
                Text("Original Title - \(viewModel.movie.originalLanguage)")
                HStack {
                    Text("\(viewModel.movie.originalTitle)")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            Text("Release Date: \(viewModel.movie.releaseDate)")
                .font(.subheadline)
                .padding(.top, 12)
            
            VStack {
                Text("Popularity: \(String(format: "%.1f", viewModel.movie.popularity))")
                    .font(.subheadline)
                Text("Vote Average: \(String(format: "%.1f", viewModel.movie.voteAverage))")
                    .font(.subheadline)
                Text("Vote Count: \(viewModel.movie.voteCount)")
                    .font(.subheadline)
            }.padding(.top, 12)
            
            VStack {
                GenresCV(genres: viewModel.genres)
            }
        }
        .padding()
        .navigationTitle(viewModel.movie.title)
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailsViewModel(movie: Movie(adult: false, backdropPath: "/uUiIGztTrfDhPdAFJpr6m4UBMAd.jpg", genreIds: [421,22232322,3,4324,544,6,7333], id: 1, originalLanguage: "en", originalTitle: "Resident Evil Death Island", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat vitae ipsum pellentesque sagittis. Vestibulum tempor velit quis ante blandit.", popularity: 8.1, posterPath: "/uUiIGztTrfDhPdAFJpr6m4UBMAd.jpg", releaseDate: "2020-01-01", title: "Hospedeiro Maldito - Ilha da Morte", video: false, voteAverage: 9.2, voteCount: 97), genres: []))
    }
}

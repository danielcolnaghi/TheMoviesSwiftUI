//
//  ContentView.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesView(moviesViewModel: MoviesViewModel(movieType: .nowPlaying))
            .badge(0)
            .tabItem {
                Label("Now Playing", systemImage: "play.rectangle")
            }
            
            MoviesView(moviesViewModel: MoviesViewModel(movieType: .popular))
            .badge(0)
            .tabItem {
                Label("Popular", systemImage: "person.3")
            }
            
            MoviesView(moviesViewModel: MoviesViewModel(movieType: .topRated))
            .badge(0)
            .tabItem {
                Label("Top Rated", systemImage: "heart")
            }
            
            MoviesView(moviesViewModel: MoviesViewModel(movieType: .upcoming))
            .badge(0)
            .tabItem {
                Label("Upcoming", systemImage: "questionmark.square.dashed")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

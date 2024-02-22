//
//  GenresCV.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 21/02/2024.
//

import SwiftUI

struct GenresCV: View {
    var genres: [String]
    let rows = [GridItem(.fixed(30))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(genres, id: \.self) { genre in
                    Text(genre)
                        .background {
                            Color.blue.opacity(0.4).padding(.all, -10)
                        }
                        .padding(10)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct GenresCV_Previews: PreviewProvider {
    static var previews: some View {
        GenresCV(genres: ["Action", "Drama", "Science Fiction"])
    }
}

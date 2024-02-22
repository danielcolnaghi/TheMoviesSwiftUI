//
//  RemoteImage.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 20/02/2024.
//

import SwiftUI

struct RemoteImage: View {
    let url: URL?
    @State private var image: Image?

    init(url: URL? = nil) {
        self.url = url
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RemoteImage(url: URL(string: "-"))
            RemoteImage(url: URL(string: "https://www.themoviedb.org/t/p/w1280/qayga07ICNDswm0cMJ8P3VwklFZ.jpg")!)
        }
    }
}

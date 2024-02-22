//
//  NetworkService.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 19/02/2024.
//

import Foundation

struct NetworkSession {
    static var shared = NetworkSession()
    private init() {}
    
    func requestAuthorization() {
        NetworkService.shared.requestURL(endPoint: .authentication, body: nil, method: .get) { data in
            
        }
    }
    
    func getGenreMovieList(completion: @escaping (_ response: GenreResponse?) -> Void) {
        self.requestGet(endPoint: NetworkService.EndPoint.genreMovieList) { response in
            completion(response)
        }
    }
    
    func getNowPlayingMovieList(completion: @escaping (_ response: MovieResponse?) -> Void) {
        self.requestGet(endPoint: NetworkService.EndPoint.movieNowPlaying) { response in
            completion(response)
        }
    }

    func getPopularMovieList(completion: @escaping (_ response: MovieResponse?) -> Void) {
        self.requestGet(endPoint: NetworkService.EndPoint.moviePopular) { response in
            completion(response)
        }
    }
    
    func getTopRatedMovieList(completion: @escaping (_ response: MovieResponse?) -> Void) {
        self.requestGet(endPoint: NetworkService.EndPoint.movieTopRated) { response in
            completion(response)
        }
    }
    
    func getUpcomingMovieList(completion: @escaping (_ response: MovieResponse?) -> Void) {
        self.requestGet(endPoint: NetworkService.EndPoint.movieUpcoming) { response in
            completion(response)
        }
    }
    
    private func requestGet<T: Codable>(endPoint: NetworkService.EndPoint, useCache: Bool = true, completion: @escaping (_ response: T?) -> Void) {
        NetworkService.shared.requestURL(endPoint: endPoint, body: nil, method: .get, useCache: useCache) { data in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(response)
                } catch (let error) {
                    print("⚠️ JSON decode error: \(error)")
                }
            } else {
                completion(nil)
            }
        }
    }
}

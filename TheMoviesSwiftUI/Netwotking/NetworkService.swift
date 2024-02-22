//
//  NetworkService.swift
//  TheMoviesSwiftUI
//
//  Created by Daniel Colnaghi on 19/02/2024.
//

import Foundation

struct NetworkService {
    static var shared = NetworkService()
    
    private init() {}

    let env = "https://api.themoviedb.org/3/"
    let Authorization = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTNjOWY3ZDhjYzY0YzNjYjQ0NTE2NDdjMjFjNjlhYSIsInN1YiI6IjU5MmRiYzRlYzNhMzY4NGE5ZTAwMTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OGVJTtKiA98OhQeDrBMFn2fp7otVfG4xK0gJiVLYMhg"

    enum EndPoint {
        case authentication
        case genreMovieList
        case movieNowPlaying
        case moviePopular
        case movieTopRated
        case movieUpcoming
        case TMPrequestWithParams(p1: Int, p2: Int)
        
        var rawValue: String {
            switch self {
            case .authentication: return "authentication"
            case .genreMovieList: return "genre/movie/list"
            case .movieNowPlaying: return "movie/now_playing"
            case .moviePopular: return "movie/popular"
            case .movieTopRated: return "movie/top_rated"
            case .movieUpcoming: return "movie/upcoming"
            case .TMPrequestWithParams(p1: let p1, p2: let p2): return "someparams/p1/\(p1)/p2/\(p2)"
            }
        }
    }
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
    }
    
    func requestURL(endPoint: EndPoint, body: Data?, method: Method, useCache: Bool = false, completion: @escaping (_ data: Data?) -> Void) {
        guard let url = URL(string: "\(env)\(endPoint.rawValue)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        
        let cache = URLCache.shared
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)), useCache == true {
            print("📦 Cached Data from \(url)")
            completion(cachedResponse.data)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("🔐 Status Code \(httpResponse.statusCode)")
                }
                if let data = data, let response = response, let url = request.url {
                    print("📦 \(String(data: data, encoding: .utf8) ?? "")")
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                }
                if let error = error {
                    print("Error \(error)")
                }
                completion(data)
            }.resume()
        }
    }
}

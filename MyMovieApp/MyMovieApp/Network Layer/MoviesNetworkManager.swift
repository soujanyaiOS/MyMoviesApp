//
//  MoviesNetworkManager.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 15/03/23.
//

import Foundation

protocol  MoviesListNetworkManagerProtocal {
    func getMoviesData(completion: @escaping(Result<MovieResponse,Error>) -> Void)
    func getFavoritesList(completion: @escaping(Result<FavoriteResponse,Error>) -> Void)
}

class MoviesListNetworkManager:  MoviesListNetworkManagerProtocal {
    
    func getMoviesData(completion: @escaping(Result<MovieResponse,Error>) -> Void) {
        let endpoint = APIEndpoint.getMoviesData
        loadResources(from: endpoint.url ,completion: completion)
    }
    
    func getFavoritesList(completion: @escaping(Result<FavoriteResponse,Error>) -> Void) {
        let endpoint = APIEndpoint.getFavourites
        loadResources(from: endpoint.url ,completion: completion)
    }
    
    private func loadResources<T: Decodable>(from path: URL,
                                             completion: @escaping(Result<T,Error>) -> Void) {
        
        let urlSession = URLSession(configuration: .default).dataTask(with: path) { (data, _, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    debugPrint("error: ", error)
                }
            }
        }
        urlSession.resume()
        
    }
}




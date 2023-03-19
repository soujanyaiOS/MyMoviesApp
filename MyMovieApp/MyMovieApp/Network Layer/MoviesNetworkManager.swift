//
//  MoviesNetworkManager.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 15/03/23.
//

import Foundation
import SwiftLoader

class MockApiService: MoviesListNetworkManagerProtocal {
    func getMoviesData(completion: @escaping(Result<MovieResponse,Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            
           
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieResponse.self, from: data)
                print(jsonData)
                completion(.success(jsonData))
            } catch {
                print("error decoding")
            }
        }
    }
    
    func getFavoritesList(completion: @escaping(Result<FavoriteResponse,Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Favourites", withExtension: "json") {

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(FavoriteResponse.self, from: data)
                print(jsonData)
                completion(.success(jsonData))
            } catch {
                print("error decoding")
            }
        }
    }
}


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
        
        SwiftLoader.show(animated: true)
        let urlSession = URLSession(configuration: .default).dataTask(with: path) { (data, _, error) in
            
            SwiftLoader.hide()
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




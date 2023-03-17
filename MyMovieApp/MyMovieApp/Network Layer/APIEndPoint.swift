//
//  APIEndPoint.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 15/03/23.
//

import Foundation
enum APIEndpoint {
 
    case getMoviesData
    case getFavourites
    case movieImage(id: String)
    
    var url: URL {
        switch self {
        
        case .getMoviesData:
            let urlString = "https://61efc467732d93001778e5ac.mockapi.io/movies/list"
            return URL(string: urlString)!
            
        case .getFavourites:
            let urlString = "https://61efc467732d93001778e5ac.mockapi.io/movies/favorites"
            return URL(string: urlString)!
            
        case .movieImage(let id):
            let urlString = "https://image.tmdb.org/t/p/w500\(id)"
            return URL(string: urlString)!
                    
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getMoviesData:
            return "GET"
        case .getFavourites:
            return "GET"
            
        case .movieImage:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}


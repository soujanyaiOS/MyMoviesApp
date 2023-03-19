//
//  FavouriteModel.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 17/03/23.
//

import Foundation
struct Favorite : Codable {
    let id: Int?
    enum CodingKeys: String, CodingKey{
        case id = "id"
    }
}

public struct FavoriteResponse: Codable{
    let results: [Favorite]
}


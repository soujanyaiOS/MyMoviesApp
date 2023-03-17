//
//  String+Extensions.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 17/03/23.
//

import Foundation
extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}

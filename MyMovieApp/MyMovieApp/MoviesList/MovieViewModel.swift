//
//  MovieViewModel.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 14/03/23.
//

import Foundation
class MovieViewModel {
    weak var coordinator : AppCoordinator!
    
    func showDetailsScreen(){
        coordinator.showDetails()
    }
}

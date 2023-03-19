//
//  AppCoordinator.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 14/03/23.
//

import UIKit

import Foundation

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        let movieListVC = MoviesListViewController()
        let moviesDetailVM = DetailsCoordinator.init()
        moviesDetailVM.appCoordinator = self
        movieListVC.detailsCoorinator = moviesDetailVM
        navigationController.pushViewController(movieListVC, animated: true)
    }
    
    func showDetails(movieDetails: MovieDetails) {
        let deatilsVC = DetailsViewController()
        deatilsVC.movieItem = movieDetails
        navigationController.pushViewController(deatilsVC, animated: true)
        
    }
}

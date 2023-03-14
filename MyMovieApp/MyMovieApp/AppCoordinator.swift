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
        let loginViewController = MoviesListViewController()
        let loginViewModel = DetailsViewModel.init()
        loginViewModel.appCoordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func showDetails() {
        let item =    ListItem(title: "Item 1", details: "Details for Item 1")
        let loginViewController = DetailsViewController(item: item)
        navigationController.pushViewController(loginViewController, animated: true)
            
    }
}

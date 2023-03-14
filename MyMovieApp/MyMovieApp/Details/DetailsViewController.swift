//
//  DetailsViewController.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 13/03/23.
//

import UIKit



class DetailsViewController: UIViewController {
    let item: ListItem
    var viewModel =  MovieViewModel()
   
    init(item: ListItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        title = item.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        // viewModel.showDetailsScreen()
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = item.details
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}

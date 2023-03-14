//
//  ViewController.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 13/03/23.
//

import UIKit

struct ListItem {
    let title: String
    let details: String
}


class MoviesListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var viewModel = DetailsViewModel()
    lazy var tableView =  UITableView()
    var coordinator: AppCoordinator?
    
    let items = [
        ListItem(title: "Item 1", details: "Details Item 1"),
        ListItem(title: "Item 2", details: "Details Item 2"),
        ListItem(title: "Item 3", details: "Details Item 3")
    ]
    
    
    @objc func showDetails() {
        coordinator?.showDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        edgesForExtendedLayout = .all
        super.viewDidLoad()
        title = "List"
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.appCoordinator.showDetails()
    }
    
}


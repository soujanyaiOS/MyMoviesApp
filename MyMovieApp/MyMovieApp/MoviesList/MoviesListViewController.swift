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
    var detailsVMObj = DetailsViewModel()
    
    lazy var viewModel = {
        MovieViewModel()
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MoviesListTableCell.self, forCellReuseIdentifier: MoviesListTableCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        edgesForExtendedLayout = .all
        super.viewDidLoad()
        title = "Movies App"
        setupUI()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.getMovies()
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return section == 0 ?  1 : viewModel.movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.section  == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "jkhjkhjhjh"
           
            return cell
        }
        else {
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableCell", for: indexPath) as? MoviesListTableCell{
                let cellVM = viewModel.getCellViewModel(at: indexPath)
                cell1.cellViewModel = cellVM
                return cell1
                
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        detailsVMObj.appCoordinator.showDetails(movieDetails: cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ?  200 : 50
    }

}


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
    var detailsCoorinator = DetailsCoordinator()
    
    lazy var viewModel = {
        MovieViewModel()
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(MoviesListTableCell.self, forCellReuseIdentifier: MoviesListTableCell.identifier)
        tableView.register(HorizontalTableViewCell.self, forCellReuseIdentifier: HorizontalTableViewCell.identifier)
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
        
        tableView.anchorView(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: 1, paddingLeft: 10, paddingRight: 10, bottom: view.bottomAnchor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.sections[section].movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.section  == 0 {
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "HorizontalTableViewCell", for: indexPath) as? HorizontalTableViewCell{
                let cellVM = viewModel.sections[indexPath.section].movies
                cell1.detailsCoorinator = detailsCoorinator
                cell1.cellViewModel = cellVM
                return cell1
                
            }
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
        detailsCoorinator.appCoordinator.showDetails(movieDetails: cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        let label = UILabel()
        label.frame = CGRect(x:10, y: 0, width: tableView.bounds.width - 20 , height: 44)
        label.text = viewModel.sections[section].name
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .blue
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ?  200 : 50
    }
    
}


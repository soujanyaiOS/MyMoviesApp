//
//  ViewController.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 13/03/23.
//

import UIKit
import ToastViewSwift

struct ListItem {
    let title: String
    let details: String
}

class MoviesListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var detailsCoorinator = DetailsCoordinator()
    var movieObj = MovieDetails()
  
    lazy var viewModel = {
        MovieViewModel()
    }()
    
    let nextButton = UIButton(type: .system)
  
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(MoviesListTableCell.self, forCellReuseIdentifier: MoviesListTableCell.identifier)
        tableView.register(HorizontalTableViewCell.self, forCellReuseIdentifier: HorizontalTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
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
    
    @objc func showDetails() {
        if  !movieObj.title.isEmpty {
            self.detailsCoorinator.appCoordinator.showDetails(movieDetails: self.movieObj )
        }
        else {
            let toast = Toast.text("Please select any movie to show details")
            toast.show()
        }
        
    }
    
    private func nextButtonSetup() {
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        self.view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        nextButton.anchorTable(top: nil,
                               leading: nil,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               trailing: nil,
                               paddingBottom: 0,
                               width: self.tableView.frame.width - 20,
                               height: 44)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func initViewModel() {
        viewModel.getMovies()
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.nextButtonSetup()
                self?.view.bringSubviewToFront(self!.nextButton)
            }
        }
    }
    
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchorTable(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.trailingAnchor)
        
        
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
                cell1.delegate = self
                let cellVM = viewModel.sections[indexPath.section].movies
                cell1.movieID = viewModel.selectedMovieId
                cell1.cellViewModel = cellVM
                return cell1
            }
        }
        else {
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableCell", for: indexPath) as? MoviesListTableCell{
                let cellVM = viewModel.getCellViewModel(at: indexPath)
                cell1.movieID = viewModel.selectedMovieId
                cell1.cellViewModel = cellVM
                return cell1
                
            }
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieObj = viewModel.getCellViewModel(at: indexPath)
        viewModel.selectedMovieId = movieObj.id
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        let label = UILabel()
        label.frame = CGRect(x:10, y: 0, width: tableView.bounds.width - 20 , height: 44)
        label.text = viewModel.sections[section].name
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ?  150 : 50
    }
}

extension MoviesListViewController : HorizontalTableViewCellDelegate {
    func movieCellHorizontalDelegate( didselect item: MovieDetails) {
        movieObj = item
        viewModel.selectedMovieId = movieObj.id
    }
}


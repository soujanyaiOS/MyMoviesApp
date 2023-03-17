//
//  MovieViewModel.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 14/03/23.
//

import Foundation

struct MoviesCellViewModel {
//    var backdrop_path: String = ""
    var id: Int = 0
//    var original_language: String = ""
//    var original_title: String = ""
//    var overview: String = ""
//    var popularity: Float = 0.0
//    var poster_path: String = ""
//    var release_date: String = ""
    var title: String = ""
//    var rating: Float = 0.0
//    var isWatched: Bool = false
}
class MovieViewModel {
    weak var coordinator : AppCoordinator!
    var reloadTableView: (() -> Void)?
    var movies = MoviesList()
    
    var postCellViewModels = [MoviesCellViewModel](){
        didSet {
            reloadTableView?()
        }
    }
    
    private var postApiService: MoviesListNetworkManagerProtocal

    init(postApiService: MoviesListNetworkManagerProtocal = MoviesListNetworkManager()) {
        self.postApiService = postApiService
    }
    
    func fetchData(posts: MoviesList) {
        self.movies = posts
        var vms = [MoviesCellViewModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        postCellViewModels = vms
    }
    
    func createCellModel(post: MovieDetails) -> MoviesCellViewModel {
        let idValue = post.id
        let title = post.title
      
        return MoviesCellViewModel(id: idValue, title: title)
    }
    
    func getMovies() {
        postApiService.getMoviesData { data in
            switch data {
            case .success(let movie):
                print(movie)
                self.fetchData(posts: movie.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MoviesCellViewModel {
        return postCellViewModels[indexPath.row]
    }
   
}

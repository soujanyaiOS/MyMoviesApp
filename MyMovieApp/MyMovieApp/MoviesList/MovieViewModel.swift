//
//  MovieViewModel.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 14/03/23.
//

import Foundation

struct MovieSection {
    var name: String
    var movies: MoviesList
}

class MovieViewModel {
    weak var coordinator : AppCoordinator!
    var reloadTableView: (() -> Void)?
    var movies = MoviesList()
    var sections = [MovieSection]() {
        didSet {
            reloadTableView?()
        }
    }
 
    var favoritesList = [MovieDetails]()
    var watchedMoview = [MovieDetails]()
    private var toWatchMoview = [MovieDetails]()
    private var postApiService: MoviesListNetworkManagerProtocal

    init(postApiService: MoviesListNetworkManagerProtocal = MoviesListNetworkManager()) {
        self.postApiService = postApiService
    }
    
    func getMovies() {
        postApiService.getMoviesData {[weak self] data in
            switch data {
            case .success(let movie):

                self?.movies = movie.results
                self?.movies.sort {
                    $0.rating > $1.rating
                }
                self?.getFavourites()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getFavourites() {
        postApiService.getFavoritesList { data in
            switch data {
            case .success(let favourites):
                self.sorteddataFavorites(favourite: favourites.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    ///GET FAVOURITES
    private func sorteddataFavorites(favourite: [Favorite]) {
            for element in self.movies {
                for value in favourite {
                    if element.id == value.id {
                        self.favoritesList.append(element)
                        let index = self.movies.firstIndex{ $0.id == element.id} ?? 0
                        self.movies.remove(at: index)
                    }
                }
            }
            self.watchedMoview = self.movies.filter { $0.isWatched == true  }
            self.toWatchMoview =  self.movies.filter { $0.isWatched == false }
            self.watchedMoview.append(contentsOf: self.favoritesList)
            self.toWatchMoview.append(contentsOf: self.favoritesList)
        
         sections = [
                      MovieSection(name: "Watched", movies: self.watchedMoview),
                      MovieSection(name: "Unwatched", movies: self.toWatchMoview),
                      MovieSection(name: "Favourites", movies: self.favoritesList)
                   ]
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MovieDetails {
        return sections[indexPath.section].movies[indexPath.row]
    }
   
}

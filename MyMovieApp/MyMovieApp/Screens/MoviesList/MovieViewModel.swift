//
//  MovieViewModel.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 14/03/23.
//

import UIKit

struct MovieSection {
    var name: String
    var movies: MoviesList
}

final class MovieViewModel {
    weak var coordinator : AppCoordinator!
    var reloadTableView: (() -> Void)?
    var movies = MoviesList()
    var sections = [MovieSection]() {
        didSet {
            reloadTableView?()
        }
    }
    init(apiService: MoviesListNetworkManagerProtocal) {
        self.postApiService = apiService
    }
    
    var favoritesList = [MovieDetails]()
    var watchedMoview = [MovieDetails]()
    private var toWatchMoview = [MovieDetails]()
    private var postApiService: MoviesListNetworkManagerProtocal
    
    init(postApiService: MoviesListNetworkManagerProtocal = MoviesListNetworkManager()) {
        self.postApiService = postApiService
    }
    
    
    
    var selectedMovieId = 0
    
    func didSelectRowAt(movieId: Int) {
        selectedMovieId = movieId
    }
    
    
    func backgroundColor(forMovieId movieId: Int) -> UIColor {
        return selectedMovieId == movieId ? UIColor.lightGray : UIColor.clear
    }
    
    func getMovies() {
        postApiService.getMoviesData {[weak self] data in
            switch data {
            case .success(let movie):
                self?.movies = movie.results
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
    
    ///Create TAble sectiondata
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
        
        sections = [
            MovieSection(name: "Favourites", movies: self.sorMoviesByRatingName(movies: self.favoritesList)),
            MovieSection(name: "Watched", movies: self.sorMoviesByRatingName(movies: self.watchedMoview)),
            MovieSection(name: "To Watch", movies: self.sorMoviesByRatingName(movies: self.watchedMoview))
            
        ]
    }
    
    private func sorMoviesByRatingName(movies: [MovieDetails]) -> [MovieDetails]{
        var movieList = movies
        movieList = movies.sorted { (movie1, movie2) -> Bool in
            if movie1.rating > movie2.rating {
                return true
            } else if movie1.rating == movie2.rating {
                return movie1.title < movie2.title
            } else {
                return false
            }
        }
        return movieList
    }
    
    
    
    func getCellViewModel(at indexPath: IndexPath) -> MovieDetails {
        return sections[indexPath.section].movies[indexPath.row]
    }
    
}

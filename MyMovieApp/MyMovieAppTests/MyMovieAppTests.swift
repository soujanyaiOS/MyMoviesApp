//
//  MyMovieAppTests.swift
//  MyMovieAppTests
//
//  Created by soujanya Balusu on 13/03/23.
//

import XCTest
@testable import MyMovieApp

class MyMovieAppTests: XCTestCase {
    
    var viewModel: MovieViewModel!
    var mockApiService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        viewModel = MovieViewModel(apiService: mockApiService)
    }
    
    func testFetchPosts() {
        // Given
        let expectation = self.expectation(description: "Fetch Movies")
        var result: Result<MovieResponse, Error>?
        
        mockApiService.getMoviesData{ res in
            result = res
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            guard let movieslist = try? result?.get() else {
                XCTFail("Expected success, but got failure.")
                return
            }
            XCTAssertEqual(movieslist.results.count, 20)
            XCTAssertEqual(movieslist.results[0].title, "Free Guy")
            
            XCTAssertEqual(movieslist.results[0].overview, "A bank teller called Guy realizes he is a background character in an open world video game called Free City that will soon go offline.")
        }
    }
    
    func testFetchFavourites() {
        // Given
        let expectation = self.expectation(description: "Fetch Favourites")
        var result: Result<FavoriteResponse, Error>?
        
        mockApiService.getFavoritesList{ res in
            result = res
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            guard let favouruteIdsList = try? result?.get() else {
                XCTFail("Expected success, but got failure.")
                return
            }
            XCTAssertEqual(favouruteIdsList.results.count, 6)
            XCTAssertEqual(favouruteIdsList.results.first?.id, 1)
            XCTAssertEqual(favouruteIdsList.results.last?.id, 17)
            
            self.viewModel.getMovies()
            self.viewModel.getFavourites()
            XCTAssertEqual(self.viewModel.sections.count, 3)
            XCTAssertEqual(self.viewModel.sections.first?.movies.count, 6)
            XCTAssertEqual(self.viewModel.sections.last?.movies.count, 8)
            XCTAssertEqual(self.viewModel.sections.first?.movies.first?.title, "Free Guy")
            XCTAssertEqual(self.viewModel.sections.last?.movies.first?.rating, 7.6)
            XCTAssertEqual(self.viewModel.sections.last?.movies.first?.overview, "Peace and tranquility have set in Belogorie. The evil was defeated and Ivan is now enjoying his well-deserved fame. He is surrounded by his family, friends and small wonders from the modern world that help him lead a comfortable life. Luckily, he has his Magic Sword to cut a gap between the worlds to get some supplies quite regularly. But when an ancient evil rises and the existence of the magic world is put to danger, Ivan has to team up with his old friends and his new rivals. They will set out on a long journey beyond the known world to find a way to defeat the enemies and to return peace to Belogorie.")
            XCTAssertEqual(self.viewModel.sections.last?.movies.first?.release_date, "2021-01-01")
            
        }
    }
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    
}

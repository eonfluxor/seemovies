//
//  APITests.swift
//  CIE-DEMOTests
//
//  Created by hassan uriostegui on 9/22/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import XCTest

class APITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEndpointsURL() {
    
        var endpointURL = Services.api.endpoint("/test")
        var expectedURL = "/test?api_key=\(APIService.API_KEY_V3)"
        
        XCTAssert( endpointURL == expectedURL)
        
        endpointURL =  Services.api.endpoint(APIEndpoints.trendingMovies())
        expectedURL = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIService.API_KEY_V3)"
       
        XCTAssert( endpointURL == expectedURL)
        
        endpointURL =  Services.api.endpoint(APIEndpoints.movieInfo(movieId:"1"))
        expectedURL = "https://api.themoviedb.org/3/movie/1?api_key=\(APIService.API_KEY_V3)"
        
        XCTAssert( endpointURL == expectedURL)
        
        endpointURL =  Services.api.endpoint(APIEndpoints.similarMovies(movieId:"1"))
        expectedURL = "https://api.themoviedb.org/3/movie/1/recommendations?api_key=\(APIService.API_KEY_V3)"
        
        XCTAssert( endpointURL == expectedURL)
        
    }
    
    func testMovieEndpoint(){
        let mid = "429617"
        let exp = expectation(description: "getMovie")
        
        Services.api.get(movieId: mid) { (movie) in
           
            if movie.id == mid {
                 exp.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    
  

}

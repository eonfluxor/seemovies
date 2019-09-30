//
//  APIEndpoints.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

enum APIEndpoints {
    
    case getMovie(String)
    case getMovieRelated(String)
    case getTrendingMovies(Int)
    
    func url()->String{
        
        switch self {
        case .getMovie(let movieId):
             return signedUrl("https://api.themoviedb.org/3/movie/\(movieId)")
            
        case .getTrendingMovies(let page):
             return signedUrl("https://api.themoviedb.org/3/trending/movie/day?page=\(page)")
            
        case .getMovieRelated(let movieId):
              return signedUrl("https://api.themoviedb.org/3/movie/\(movieId)/recommendations")
       
        }
    }
}

extension APIEndpoints {
    
    fileprivate func signedUrl(_ urlstring:String)->String{
        
        let url = URL(string: urlstring)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems =  Array(components.queryItems ?? [])
        queryItems.append( URLQueryItem(name: "api_key", value: APIService.API_KEY_V3))
        components.queryItems = queryItems
        
        if let finalstring = try? components.asURL().absoluteString {
            return finalstring
        }
        
        fatalError("this should never be reached")
    }
}


//
//  APIEndpoints.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

enum APIEndpointName {
    case getMovie(String)
    case getMovieRelated(String)
    case getTrendingMovies(Int)
}

struct APIEndpoints {
   
    static func endpoint(_ urlstring:String)->String{
        
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
    
    static func trendingMovies(page: Int = 1)->String{
        return endpoint("https://api.themoviedb.org/3/trending/movie/day?page=\(page)")
    }
    
    static func similarMovies(movieId : String)->String{
        return endpoint("https://api.themoviedb.org/3/movie/\(movieId)/recommendations")
    }
    
    static func movieInfo(movieId : String)->String{
        return endpoint("https://api.themoviedb.org/3/movie/\(movieId)")
    }

}

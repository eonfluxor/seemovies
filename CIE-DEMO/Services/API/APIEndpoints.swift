//
//  APIEndpoints.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

struct APIEndpoints {
    
    static func trendingMovies()->String{
        return "https://api.themoviedb.org/3/trending/movie/day"
    }
    
    static func similarMovies(_ movie : Movie)->String{
        guard let mid = movie.id else {
            fatalError("movie id is required")
        }
        return "https://api.themoviedb.org/3/movie/\(mid)/recommendations"
    }
    
    static func movieInfo(_ movieId : String)->String{
        return "https://api.themoviedb.org/3/movie/\(movieId)"
    }

}

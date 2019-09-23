//
//  APIEndpoints.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

struct APIEndpoints {
    
    static func trendingMovies(page: Int = 1)->String{
        return "https://api.themoviedb.org/3/trending/movie/day?page=\(page)"
    }
    
    static func similarMovies(movieId : String)->String{
        return "https://api.themoviedb.org/3/movie/\(movieId)/recommendations"
    }
    
    static func movieInfo(movieId : String)->String{
        return "https://api.themoviedb.org/3/movie/\(movieId)"
    }

}

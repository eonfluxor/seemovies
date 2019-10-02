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
             return signedUrl("/movie/\(movieId)")
            
        case .getTrendingMovies(let page):
             return signedUrl("/trending/movie/day?page=\(page)")
            
        case .getMovieRelated(let movieId):
              return signedUrl("/movie/\(movieId)/recommendations")
       
        }
    }
}

extension APIEndpoints {
    
    
    fileprivate func apiBaseURL()->String{
       
        return "https://api.themoviedb.org/3"
    }
    
    fileprivate func signedUrl(_ path:String)->String{
        
        let urlstring = "\(apiBaseURL())\(path)"
        
        guard let url = URL(string: urlstring) else{
            assert(false,"this should never be reached")
            return urlstring
        }
        
        let signatureParams = ["api_key": APIService.API_KEY_V3]
        let composedURL = APIService.compose(url: url, params: signatureParams)
        
        if let finalstring =  composedURL?.absoluteString {
            return finalstring
        }
        
        assert(false,"this should never be reached")
        return urlstring
    }
    
    
}

extension APIService {
    
    static func compose(url:URL, params:[String:String])->URL?{
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems =  Array(components.queryItems ?? [])
        
        params.forEach { param in
             queryItems.append( URLQueryItem(name: param.key, value: param.value))
        }
        components.queryItems = queryItems
        
        return try? components.asURL()
        
    }
}


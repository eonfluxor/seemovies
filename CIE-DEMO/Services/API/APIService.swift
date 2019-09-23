//
//  APIService.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

typealias APIMovieListCompletion = ([Movie])->Void
typealias APIMovieCompletion = (Movie)->Void


class APIService: NSObject {
    
    //TODO: Revoke and read from external (non-github) file (maybe git-crypt)
    static let API_KEY_V3 = "43af0066f64198f00c8d98d9d347b31f"
    
    func endpoint(_ urlstring:String)->String{
        
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
    
    func getMoviesList(from page:Int = 1, _ completion:@escaping APIMovieListCompletion)->Void{
        Alamofire.request(endpoint(APIEndpoints.trendingMovies(page: page))).responseObject { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
            }
            DispatchQueue.main.async {
                completion(response.results ?? []);
            }
        }
    }
    
    func getSimilarTo(movieId : String, _ completion:@escaping APIMovieListCompletion) {
        Alamofire.request(endpoint(APIEndpoints.similarMovies(movieId:movieId))).responseObject { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
            }
            DispatchQueue.main.async {
                completion(response.results ?? []);
            }
        }
    }
    
    func get(movieId : String, _ completion:@escaping APIMovieCompletion) {
        Alamofire.request(endpoint(APIEndpoints.movieInfo(movieId:movieId))).responseObject { (response: DataResponse<Movie>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
            }
            
            DispatchQueue.main.async {
                completion(response);
            }
        }
    }
    
    
    
}

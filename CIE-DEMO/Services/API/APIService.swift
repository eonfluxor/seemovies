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
    
    func endpoint(_ url:String)->String{
        return "\(url)?api_key=\(APIService.API_KEY_V3)"
    }
    
    func getMoviesList(from page:Int? = nil, _ completion:@escaping APIMovieListCompletion)->Void{
      
        Alamofire.request(endpoint(APIEndpoints.trendingMovies())).responseObject { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
            }
            DispatchQueue.main.async {
                completion(response.results ?? []);
            }
        }
    }
    
    func get(movieId : String, _ completion:@escaping APIMovieCompletion) {
        Alamofire.request(endpoint(APIEndpoints.movieInfo(movieId))).responseObject { (response: DataResponse<Movie>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
            }
            
            DispatchQueue.main.async {
                completion(response);
            }
        }
    }
    
}

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
typealias APIMovieListOptCompletion = ([Movie]?)->Void
typealias APIMovieCompletion = (Movie)->Void
typealias APIMovieOptCompletion = (Movie?)->Void


class APIService: NSObject {
    
    //TODO: Revoke and read from external (non-github) file (maybe git-crypt)
    static let API_KEY_V3 = "43af0066f64198f00c8d98d9d347b31f"
    let QUEUE = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)
    
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
    
    func getMoviesList(from page:Int = 1, _ completion:@escaping APIMovieListOptCompletion)->Void{
        Alamofire.request(endpoint(APIEndpoints.trendingMovies(page: page))).responseObject(queue: QUEUE) { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
                completion(nil)
            }
            DispatchQueue.main.async {
                completion(response.results ?? []);
            }
        }
    }
    
    func getSimilarTo(movieId : String, _ completion:@escaping APIMovieListOptCompletion) {
        Alamofire.request(endpoint(APIEndpoints.similarMovies(movieId:movieId))).responseObject(queue: QUEUE) { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
                completion(nil)
            }
            DispatchQueue.main.async {
                completion(response.results ?? []);
            }
        }
    }
    
    func get(movieId : String, _ completion:@escaping APIMovieOptCompletion) {
        Alamofire.request(endpoint(APIEndpoints.movieInfo(movieId:movieId))).responseObject(queue: QUEUE) { (response: DataResponse<Movie>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexepcted response format")
                completion(nil);
            }
            
            DispatchQueue.main.async {
                completion(response);
            }
        }
    }
}




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

typealias APIResourceClosure<K> = (K?)->Void

class APIService: NSObject {
    
    //TODO: Revoke and read from external (non-github) file (maybe git-crypt)
    static let API_KEY_V3 = "43af0066f64198f00c8d98d9d347b31f"
    static let QUEUE = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)
    
    static func getMovie(_ endpointURL:String, completion: @escaping APIResourceClosure<Movie>) -> Void {
        
        Alamofire.request(endpointURL).responseObject(queue: APIService.QUEUE) { (response: DataResponse<Movie>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexpected response format")
                completion(nil)   
            }
            
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
    
    static func getMovies(_ endpointURL:String, completion: @escaping APIResourceClosure<[Movie]>) -> Void {
        
        Alamofire.request(endpointURL).responseObject(queue: APIService.QUEUE) { (response: DataResponse<APIResponseMovieList>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexpected response format")
                completion(nil)
            }
            
            guard let resource = response.results else {
                assert(false, "Unexpected response format")
                completion(nil)
            }
            
            DispatchQueue.main.async {
                completion(resource)
            }
        }
    }
}




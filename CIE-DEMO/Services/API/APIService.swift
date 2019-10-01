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
import ObjectMapper

typealias APIClosure<K> = (K?)->Void

class APIService: NSObject {
    
    //TODO: Revoke and read from external (non-github) file (maybe git-crypt)
    static let API_KEY_V3 = "43af0066f64198f00c8d98d9d347b31f"
    static let QUEUE = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)
    
    
    static func get<K:Mappable>(_ endpoint:APIEndpoints, completion: @escaping APIClosure<K>) -> Void {
        APIService.get(endpoint.url(), completion: completion)
    }
    
    static func get<K:Mappable>(_ endpointURL:String, completion: @escaping APIClosure<K>) -> Void {
        
        Alamofire.request(endpointURL).responseObject(queue: APIService.QUEUE) { (response: DataResponse<K>) in
            
            guard let response = response.result.value else {
                assert(false, "Unexpected response format")
                completion(nil)
            }
            
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}




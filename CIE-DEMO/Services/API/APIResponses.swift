//
//  APIResponses.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import ObjectMapper

protocol APIResponse {
    func items<K>(_ type:K.Type?)->[K]
}


extension Movie: APIResponse{
    func  items<K>(_ type:K.Type? = nil)->[K]{
        return ([self] as? [K]) ?? []
    }
}

struct APIResponseMovieList: Mappable,APIResponse {
    
    var page: Int?
    var results: [Movie]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
    }
    
    func  items<K>(_ type:K.Type? = nil)->[K]{
        return (results as? [K]) ?? []
    }
    
}





//
//  APIResponses.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import ObjectMapper

struct APIResponseMovieList: Mappable {
    
    var page: Int?
    var results: [Movie]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
    }
    
    
    
    
    
}

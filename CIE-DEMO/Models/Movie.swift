//
//  Movie.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import ObjectMapper


struct Genre : Mappable, Codable{
    
    var id:String?
    var idInt:Int?
    var name:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idInt   <- map["id"]
        name   <- map["name"]
        
        id = "\(idInt ?? 0)"
    }
}

struct Movie : Mappable, Codable{
    
    var id:String?
    var idInt:Int?
    var title:String! = "Untitled"
    var description:String! = ""
    var backdrop_path:String?
    var back_url:String?
    var poster_url:String?
    var poster_path:String?
    var release_date_string:String?
    var vote_count:Int?
    var vote_average:Float?
    var tagline:String?
    var status:String?
    var genres:[Genre]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idInt           <-  map["id"]
        status          <-  map["status"]
        tagline         <-  map["tagline"]
        title           <-  map["title"]
        description     <-  map["overview"]
        backdrop_path   <- map["backdrop_path"]
        poster_path     <- map["poster_path"]
        release_date_string <- map["release_date"]
        vote_count      <- map[ "vote_count"]
        vote_average    <- map["vote_average"]
        genres          <- map["genres"]
        
        id = "\(idInt ?? 0)"
        back_url = "https://image.tmdb.org/t/p/original\(backdrop_path ?? "")"
        poster_url = "https://image.tmdb.org/t/p/original\(poster_path  ?? "")"
    }
    
    func  genresTitle() -> String {
        
        guard let genres = genres else {
            return ""
        }
        
        let array = Array(genres)
        let names : Array = array.map({ $0.name ?? "" })
        
        return names.joined(separator: ", ")
  
       
    }
    
    
}


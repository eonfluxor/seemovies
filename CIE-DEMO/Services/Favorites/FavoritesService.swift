//
//  FavoritesService.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class FavoritesService: NSObject {

    func isFav(movie : Movie)->Bool{
        
        guard let id = movie.id else {
            return false
        }
        let state = Services.flux.state
        let favs : [String:Movie]  = state?.favs ?? [:]
        return favs[id] != nil
        
    }
}

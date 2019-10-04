//
//  MoviesCollectionView+Favs.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class MovieFavsCollectionView: MoviesCollectionView {
    
    
    override func isInfiniteFeed()->Bool{
        return false
    }
    
    override func cellName()->String{
        return "MovieFavCell"
    }
    
    override func loadMovies(){
        
        let state = Services.flux.state
        
        guard let favValues = state?.favs.values else {
            return
        }
        
        let sorted = favValues.sorted(by:{ $0.sortIndex > $1.sortIndex })
        moviesBehavior.accept(sorted)
    }
}

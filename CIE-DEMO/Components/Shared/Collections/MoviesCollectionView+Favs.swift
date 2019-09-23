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
    
    override func loadMovies(){
        
        let state = Services.flux.state
        
        guard let favValues = state?.favs.values else {
            return
        }
       
        refreshControl.endRefreshing()
        movies = Array(favValues)
        collectionView.reloadData()
    }
}

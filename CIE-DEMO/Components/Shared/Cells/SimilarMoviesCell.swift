//
//  SimilarMoviesCell.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class SimilarMoviesCell:  DisplayGenericCell<SimilarMoviesView> {

    var movie : Movie!
    
    func setupWith(movie: Movie){
        self.movie = movie
//        displayView.setupWith(movie: movie)
    }
}

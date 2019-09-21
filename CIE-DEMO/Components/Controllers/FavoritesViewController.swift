//
//  HomeController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed

class FavoritesViewController: UIViewController  {
    
    var list : MoviesCollectionView!
    var presentingDetail : Bool = false
    
    override func viewDidLoad() {
        setupCollectionView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentingDetail = false
    }
    
}

extension FavoritesViewController: MoviesCollectionViewProtocol{
    
    
    func setupCollectionView(){
        let list = MoviesCollectionView()
        list.setupWithFrame(frame: self.view.bounds)
        list.delegate = self
        self.view.addSubview(list)
        self.list = list
        
    }
    
    func didSelectMovie(_ movie:Movie) {
        
        if(self.presentingDetail){ return; }
        self.presentingDetail = true
        
//        let detailAnimator = NavAnimators.SlideLeft()
//        Services.router.tab(.Favorites).push(controller: .MovieDetail, animator:detailAnimator)
        
    }
}

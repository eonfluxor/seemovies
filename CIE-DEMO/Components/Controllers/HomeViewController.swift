//
//  HomeController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed

class HomeViewController: BaseViewController  {
    
    var list : MoviesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView();
        reloadData();
    }

}

extension HomeViewController{
    
    func setupCollectionView(){
        let list = MoviesCollectionView()
        list.setupWithFrame(frame: self.view.bounds)
        list.delegate = self
        self.view.addSubview(list)
        
        
        list.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.list = list
        
    }
    
    func reloadData(){
        assert(self.list != nil, "Movie list not initialized!")
        self.list.loadMovies()
    }
}

extension HomeViewController: MoviesCollectionViewProtocol{
    
    
    
    func didSelectMovie(_ movie:Movie) {
        
        
        
        Services.router.pushDetailViewController(movie: movie)
        //        let detailAnimator = NavAnimators.ZoomOut()
        //        Services.router.tab(.Home).push(controller: .MovieDetail, info:NavInfo(params:["movie":movie]), animator:detailAnimator)
        
    }
}

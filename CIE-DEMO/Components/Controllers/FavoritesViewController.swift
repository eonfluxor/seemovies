//
//  HomeController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed
import ReSwift

class FavoritesViewController: BaseViewController {
    
    typealias StoreSubscriberStateType = FluxState
    
    var list : MovieFavsCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView();
        
        Services.flux.subscribe(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Favorites"
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.titleTextAttributes = nil
        navigationController?.navigationBar.tintColor = Services.theme.BLACK
        reloadData()
    }
    
}

extension FavoritesViewController:StoreSubscriber {
    
    func newState(state: FluxState) {
        // update when new elements are added
        // for a more complex app we want to observe only specific keys with subscription filtering
        reloadData()
    }
}

extension FavoritesViewController{
    
    func setupCollectionView(){
        let list = MovieFavsCollectionView()
        list.setup()
        list.delegate = self
        view.addSubview(list)
        
        
        list.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.list = list
        
    }
    
    func reloadData(){
        guard let list = self.list else {
            return
        }
        list.loadMovies()
    }
}

extension FavoritesViewController: MoviesCollectionViewProtocol{
    
    func didSelectMovie(_ movie:Movie) {
        Services.router.pushDetailViewController(movie: movie)
        //        let detailAnimator = NavAnimators.ZoomOut()
        //        Services.router.tab(.Home).push(controller: .MovieDetail, info:NavInfo(params:["movie":movie]), animator:detailAnimator)
        
    }
}

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
import RxSwift

class FavoritesViewController: BaseViewController {
    
    typealias StoreSubscriberStateType = FluxState
    
    let disposeBag = DisposeBag()
    var list : MovieFavsCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Services.theme.MID_GREY
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
        list.selectedMovie.drive(onNext:{ movie in
            if let movie = movie {
                Services.router.pushDetailViewController(movie: movie)
            }
        }).disposed(by: disposeBag)
        
        view.addSubview(list)
        
        list.snp_makeConstraints { (make) in
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.top.equalTo(0)
            make.bottom.equalTo(view.snp_bottomMargin)
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


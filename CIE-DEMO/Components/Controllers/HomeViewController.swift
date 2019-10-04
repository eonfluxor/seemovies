//
//  HomeController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed
import RxSwift

class HomeViewController: BaseViewController  {
    
    let disposeBag = DisposeBag()
    var list : MoviesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView();
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Trending"
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.tintColor = Services.theme.BLACK
        navigationController?.navigationBar.titleTextAttributes = nil
        reloadData()
    }

}

extension HomeViewController{
    
    func setupCollectionView(){
        let list = MoviesCollectionView()
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


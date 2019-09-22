//
//  MoviesCollectionView.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit


// NOTE: I am not a big fan of the protocol / delegate pattern.
// The same can be accomplished with a public closure.
// There is a sample of this in the SimilarMoviesView
protocol MoviesCollectionViewProtocol:AnyObject {
    func didSelectMovie(_ movie : Movie) //todo pass selected index and/or object
}

class MoviesCollectionView: UIView {
    
    let PADDING : Int = 8
    
    var collectionView: UICollectionView!
    var refreshControl : UIRefreshControl!
    weak var delegate :MoviesCollectionViewProtocol?
    
    var movies: [Movie] = []
}

extension MoviesCollectionView {
    
    func setup(){
        setupCollectionView()
        setupPullToRefresh()
    }
    
    func setupCollectionView(){
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView = collectionView
        
    }
    
    func setupPullToRefresh(){
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh),for: .valueChanged)
        
        collectionView.addSubview(refreshControl)
    }
    
}

extension MoviesCollectionView {
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMovies()
    }
    
    @objc func loadMovies(){
        
        Services.api.getMoviesList { [weak self] (movies) in
            self?.refreshControl.endRefreshing()
            self?.movies = movies
            self?.collectionView.reloadData()
        }
    }
}



extension MoviesCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieViewCell
        
        let movie = movies[indexPath.row]
        cell.setupWithMovie(movie)
        
        return cell
    }
}

extension MoviesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
}

extension MoviesCollectionView: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.bounds.size.width) - ( PADDING * 2 )
        let height = Services.theme.CELLS_HEIGHT
        return CGSize( width: width , height: height )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(PADDING)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}


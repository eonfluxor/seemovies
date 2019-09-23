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
    func didSelect(movie : Movie) //todo pass selected index and/or object
}

class MoviesCollectionView: UIView {
    
    let PADDING : Int = 8
    var page = 1
    var isLoading = false
    var lastMoviesCount = 0
    
    var collectionView: UICollectionView!
    var refreshControl : UIRefreshControl!
    var searchbar : UISearchBar!
    weak var delegate :MoviesCollectionViewProtocol?
    
   
    var movies: [Movie] = []
    
    func dataFiltered()->[Movie] {
        
        guard let searchText = searchbar.text else{
            return movies
        }
        
        guard searchText.count > 2 else{
            return movies
        }
        
        return movies.filter({ (movie) -> Bool in
            return movie.title.contains(searchText) || movie.description.contains(searchText)
        })
    }
    
}

extension MoviesCollectionView : UISearchBarDelegate{
    
    func setupSearch(){
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle       = .prominent
        searchBar.tintColor            = .white
        searchBar.barTintColor         = .white
        searchBar.delegate             = self
        searchBar.placeholder          = "Filter content..."
        
        addSubview(searchBar)
        
        searchBar.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topMargin)
            make.bottom.lessThanOrEqualTo(snp_topMargin).offset(60)
            make.left.equalTo(0)
            make.width.equalToSuperview()
        }
        
        self.searchbar = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        if searchText.count > 0 {
            // search and reload data source
//            self.searchBarActive    = true
//            self.filterContentForSearchText(searchText)
            self.collectionView?.reloadData()
        }else{
            // if text lenght == 0
            // we will consider the searchbar is not active
//            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    
}

extension MoviesCollectionView {
    
    func setup(){
        setupCollectionView()
        setupPullToRefresh()
        setupSearch()
    }
    
    func setupCollectionView(){
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
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
        
        guard !isLoading  else {
            return
        }
        isLoading = true
        page+=1
        
        Services.api.getMoviesList(from : self.page) { [weak self] (movies) in
            self?.isLoading = false
            self?.refreshControl.endRefreshing()
            self?.movies.append(contentsOf: movies)
            self?.syncCollectionView()
        }
    }
    
    @objc func isInfiniteFeed()->Bool{
        return true
    }
    
    func syncCollectionView() {
       
//        let lastIndex = lastMoviesCount - 1
//        let diff = dataFiltered().count - lastMoviesCount
//        lastMoviesCount = dataFiltered().count
//
//        let newCells = Array(1...diff).map { IndexPath(item: lastIndex + Int($0), section: 0) }
//
//        self.collectionView.insertItems(at: newCells)
        
        self.collectionView.reloadData()
        
    }
}



extension MoviesCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFiltered().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieViewCell
        
        let movie = dataFiltered()[indexPath.row]
        cell.setupWithMovie(movie)
        
        return cell
    }
}

extension MoviesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        delegate?.didSelect(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isInfiniteFeed() && indexPath.row == movies.count - 2 {
            loadMovies()
        }
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


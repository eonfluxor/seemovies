//
//  MoviesCollectionView.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed
import RxSwift
import RxCocoa
import RxDataSources

// NOTE: I am not a big fan of the protocol / delegate pattern.
// The same can be accomplished with a public closure.
// There is a sample of this in the SimilarMoviesView
protocol MoviesCollectionViewProtocol:AnyObject {
    func didSelect(movie : Movie) //todo pass selected index and/or object
}

class MoviesCollectionView: UIView {
    
    let PADDING : Int = 8
    let SEARCHBAR_HEIGHT: Int = 60
    let disposeBag = DisposeBag()
    
    var page = 1
    var isLoading = false
    var lastMoviesCount = 0
    
    var collectionView: UICollectionView!
    var refreshControl : UIRefreshControl!
    var searchbar : UISearchBar!
    var searchString : String? = nil
    weak var delegate :MoviesCollectionViewProtocol?
    
   
    var movies: [Movie] = []
    var sections: [MoviesSection] = []
    var dataSource : RxCollectionViewSectionedAnimatedDataSource<MoviesSection>!
    var dataSubject : PublishSubject<[MoviesSection]>!
    
    func dataFiltered()->[MoviesSection] {
        
        let sectionTitle = "Trending"
        let uniqueMovies = uniq(movies)
        
        guard let searchString = searchString else {
            return [MoviesSection(header: sectionTitle, items: uniqueMovies)]
        }
        
        guard searchString.count > 2 else{
            return [MoviesSection(header: sectionTitle, items: uniqueMovies)]
        }
        
        let string = searchString.lowercased()
        
        let moviesFiltered = uniqueMovies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(string) || movie.description.lowercased().contains(string)
        })
        
        return [MoviesSection(header: sectionTitle, items: moviesFiltered)]
    }
    
}

extension MoviesCollectionView{
    
    func setupRx(){
        
        let dataSubject = PublishSubject<[MoviesSection]>()
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<MoviesSection>(
            configureCell:{ dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withReuseIdentifier: self.cellName(), for: indexPath)  as! MovieViewCell
              
                cell.setupWithMovie(item)
                
                return cell
        })
        
        dataSource.canMoveItemAtIndexPath = { dataSource, indexPath in
            return true
        }
        dataSubject
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.dataSubject = dataSubject
        self.dataSource = dataSource
        
       
    }
}


extension MoviesCollectionView : UISearchBarDelegate{
    
    func setupSearch(){
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle       = .prominent
        searchBar.tintColor            = .white
        searchBar.barTintColor         = .white
        searchBar.delegate             = self
        searchBar.placeholder          = "Filter..."
        searchBar.isTranslucent        = true
        searchBar.backgroundColor      = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        searchBar.backgroundImage      = UIImage()
        
        if let txfSearchField  = searchBar .value(forKey: "_searchField") as? UITextField {
            txfSearchField.backgroundColor =  .clear
        }
       
        
        addSubview(searchBar)
        
        searchBar.snp_makeConstraints { (make) in
            make.top.equalTo(snp_topMargin)
            make.bottom.lessThanOrEqualTo(snp_topMargin).offset(SEARCHBAR_HEIGHT)
            make.left.equalTo(0)
            make.width.equalToSuperview()
        }
        
        self.searchbar = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText == ""  {
            cancelSearching()
            endEditing(true)
        }
        
        syncCollectionView()
        scrollToTop()
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing(true)
    }
    
    func cancelSearching(){
        DispatchQueue.main.async {
            self.searchbar.resignFirstResponder()
            self.searchbar.text = ""
        }
      
    }
   
    
}

extension MoviesCollectionView {
    
    func setup(){
        setupCollectionView()
        setupRx()
        setupPullToRefresh()
        setupSearch()
    }
    
    func setupCollectionView(){
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: cellName())
        
        let top = CGFloat(SEARCHBAR_HEIGHT + PADDING)
        collectionView.contentInset = UIEdgeInsets(top: top , left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
        
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
        
        Services.api.getMoviesList(from : page) { [weak self] (movies) in
            self?.isLoading = false
            self?.refreshControl.endRefreshing()
            self?.movies.append(contentsOf: movies)
            
            self?.syncCollectionView()
        }
    }
    
    @objc func isInfiniteFeed()->Bool{
        return true
    }
    
    @objc func cellName()->String{
        return "MovieCell"
    }
    
    func syncCollectionView() {
        Kron.debounceLast(timeOut: 0.25, resetKey: self) { (key, ctx) in
            self._syncCollectionView()
        }
        
    }
    
    func _syncCollectionView(){
        searchString = searchbar.text
        dataSubject.onNext(dataFiltered())
    }
    
    func scrollToTop(){
        if dataFiltered()[0].items.count > 1 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}


extension MoviesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = dataSource[indexPath]
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


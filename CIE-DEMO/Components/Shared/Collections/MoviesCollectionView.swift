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
//protocol MoviesCollectionViewProtocol:AnyObject {
//    func didSelect(movie : Movie) //todo pass selected index and/or object
//}

class MoviesCollectionView: UIView {
    
    let PADDING : Int = 8
    let SEARCHBAR_HEIGHT: Int = 60
    let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    var refreshControl : UIRefreshControl!
    var searchbar : UISearchBar!
//    weak var delegate :MoviesCollectionViewProtocol?
    
    var dataSource : RxCollectionViewSectionedAnimatedDataSource<MoviesSection>!
    var dataSubject : PublishSubject<[MoviesSection]>!
    
    let movies = BehaviorDriver<[Movie]>(value: [])
    let isLoading = BehaviorDriver<Bool>(value: false)
    let currentPage =  BehaviorDriver<Int>(value: 1)
    let searchString =  BehaviorDriver<String?>(value: nil)
    public let selectedMovie = BehaviorDriver<Movie?>(value: nil)
}
extension MoviesCollectionView {
    
    func dataFiltered()->[MoviesSection] {
        
        let sectionTitle = "Movies"
        let uniqueMovies = uniq(movies.value())
        
        guard let searchString = searchString.value() else {
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
    
    func dataFiltered(section: Int)->[Movie] {
        return dataFiltered()[section].items
    }
    
}

extension MoviesCollectionView{
    
    func setupRx(){
        setupRxCollectionView()
        setupRxDrivers()
    }
    
    func setupRxCollectionView(){
        
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
    
    func setupRxDrivers(){
        
        movies
            .driver
            .throttle(.milliseconds(500), latest: true)
            .drive(onNext:{ [weak self] movies in
                
                guard let this = self else { return }
                
                this.captureSearchString()
                this.isLoading.behavior.accept(false)
                this.dataSubject.onNext(this.dataFiltered())
                
            }).disposed(by: disposeBag)
        
        isLoading
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        currentPage
            .drive(onNext:{ [weak self] currentPage in
                self?.loadMovies()
            })
            .disposed(by: disposeBag)
        
        searchString
            .drive( onNext:{ [weak self] searchString in
                guard let this = self else { return }
                
                this.dataSubject.onNext(this.dataFiltered())
            })
            .disposed(by: disposeBag)
        
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
        
        searchBar.rx.cancelButtonClicked.asDriver().drive(onNext:{ [weak self] _ in
            self?.cancelSearching()
            
        }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.asDriver().drive(onNext:{ [weak self] _ in
            self?.endEditing(true)
            
        }).disposed(by: disposeBag)
        
        searchBar.rx.text.asDriver().drive( onNext:{ [weak self] searchText in
           guard let this = self else { return }
            
            if searchText == ""  {
                this.cancelSearching()
                this.endEditing(true)
            }
            
            this.searchString.accept(searchText)
            this.dataSubject?.onNext(this.dataFiltered())
            this.scrollToTop()
            
        }).disposed(by: disposeBag)
        
        self.searchbar = searchBar
    }
    
    func cancelSearching(){
        DispatchQueue.main.async {
            self.searchbar.resignFirstResponder()
            self.searchbar.text = ""
        }
    }
    
    func captureSearchString(){
        searchString.accept(searchbar?.text)
    }
   
}

extension MoviesCollectionView {
    
    func setup(){
        setupCollectionView()
        setupPullToRefresh()
        setupSearch()
        setupRx()
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
        refreshControl.rx.controlEvent([.valueChanged]).asDriver().drive(onNext:{ [weak self] _ in
            
            self?.movies.accept([])
            self?.currentPage.accept(1)
            
        }).disposed(by: disposeBag)
        
        
        collectionView.addSubview(refreshControl)
    }
    
}

extension MoviesCollectionView {
    
    @objc func loadMovies(){
        
        guard !isLoading.value() else {
            return
        }
        isLoading.behavior.accept(true)
       
        print("moviesBehavior loading \(currentPage.value())")
        
        Services.api.rx.call(.getTrendingMovies(currentPage.value()))
            .subscribe(onSuccess: { [weak self] (response:APIResponseMovieList) in
                
                guard let this = self else {
                    return
                }
                
                this.movies.behavior.accept( this.movies.value() +  response.items())
                
                
            }).disposed(by: disposeBag)
        
    }
    
    @objc func isInfiniteFeed()->Bool{
        return true
    }
    
    @objc func cellName()->String{
        return "MovieCell"
    }
    
  
    func scrollToTop(){
        if dataFiltered(section: 0).count > 1 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}


extension MoviesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = dataSource[indexPath]
        selectedMovie.accept(movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isInfiniteFeed() && indexPath.row == dataFiltered(section: 0).count - 2 {
          
            currentPage.accept(currentPage.value() + 1)
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


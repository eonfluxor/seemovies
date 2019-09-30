//
//  SimilarMoviesView.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import RxSwift

class SimilarMoviesView: UIView {

    let PADDING = Services.theme.PADDING
    
    // UI
    var titleLabel : UILabel!
    var collectionView: UICollectionView!
    
    // PIPELINE
    var didSelect : MovieClosure?
    var movies: [Movie] = []
    var movie : Movie!
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = Services.theme.LIGHT_GREY
        
        titleLabel = UILabel()
        titleLabel.textColor = Services.theme.BLACK
        titleLabel.text = "Similar Movies"
        titleLabel.font =  Services.theme.H1_FONT
        titleLabel.textAlignment = .left
        
        addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(snp_leftMargin)
            make.right.equalTo(snp_rightMargin)
            make.height.lessThanOrEqualTo(30)
            make.top.lessThanOrEqualTo(PADDING)
        }
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimilarMoviesView {
    
    func setupWith(movie: Movie){
        self.movie = movie
    }
    
    func setupCollectionView(){
        
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(snp_right)
            make.top.equalTo(titleLabel.snp_bottom).offset(PADDING)
            make.bottom.equalTo(snp_bottomMargin)
            
        }
        
        self.collectionView = collectionView
        
    }
    
}

extension SimilarMoviesView {
    func loadMovies(){
        
        guard let mid = movie.id else {
            return
        }
        
        Services.api.rx.call(.getMovieRelated(mid))
            .subscribe(onSuccess: { [weak self] (movies:[Movie]) in
                
                self?.movies = movies
                self?.collectionView.reloadData()
                
            }).disposed(by: disposeBag)
        
    }
}


extension SimilarMoviesView: UICollectionViewDataSource {
    
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

extension SimilarMoviesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        didSelect?(movie)
    }
}

extension SimilarMoviesView: UICollectionViewDelegateFlowLayout {
    
    
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

//
//  DetailController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import PINRemoteImage
import ChameleonFramework

class DetailViewController: BaseViewController {
    
    let PADDING : Int = 8
    let HEADER_CELL = "MovieDetailCell"
    
    var movie : Movie?
    var detailHeader : MovieDetailView!
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavStyle()
        setupCollectionView()
//        displayCachedInfo()
       

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = false //TODO: set to true once wrapped in scrollview
        navigationController?.setNavigationBarHidden(false, animated: true)
//        displayCachedInfo()
//        displayExtraInfo()
    }
    
    func setupNavStyle(){
        navigationItem.title = "Movie Detail"
        let textAttributes = [NSAttributedString.Key.foregroundColor: Services.theme.WHITE]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = Services.theme.WHITE
        
    }

}

extension DetailViewController {
    
    func setupWith(movie: Movie){
        self.movie = movie
    }
    
    func setupCollectionView(){
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieDetailCellView.self, forCellWithReuseIdentifier: HEADER_CELL)
        collectionView.contentInset = UIEdgeInsets(top: -90, left: 0, bottom: 0, right: 0)
        
        view.addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView = collectionView
        
    }
}




extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HEADER_CELL, for: indexPath) as! MovieDetailCellView
        
        if let movie = movie {
            cell.setupWith(movie: movie)
        }
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let movie = movies[indexPath.row]
//        delegate?.didSelectMovie(movie)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.bounds.size.width)
        let height = Int(view.frame.height * 0.6)
        return CGSize( width: width , height: height )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


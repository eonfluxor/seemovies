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
    let SIMILAR_CELL = "SimilarMoviesCell"
    
    var movie : Movie?
    var detailHeader : MovieDetailView!
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavStyle()
        setupCollectionView()
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        collectionView.reloadData()
    }
    
    func setupNavStyle(){
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
        collectionView.register(SimilarMoviesCell.self, forCellWithReuseIdentifier: SIMILAR_CELL)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView = collectionView
        
      
    }
}

extension DetailViewController {
    
    func didSelect(movie : Movie){
        Services.router.pushDetailViewController(movie: movie)
    }
}


extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        if indexPath.section == 0 {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HEADER_CELL, for: indexPath) as! MovieDetailCellView
            if let movie = movie {
                cell.setupWith(movie: movie)
            }
            return cell
            
        } else if indexPath.section == 1 {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SIMILAR_CELL, for: indexPath) as! SimilarMoviesCell
            if let movie = movie {
                cell.setupWith(movie: movie)
            }
            
            cell.displayView.didSelect = { movie in
                self.didSelect(movie : movie)
            }
            
            return cell
        }
        
        fatalError("All sections must be handled")
        return UICollectionViewCell()
       
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.bounds.size.width)
        var height = 600
        
        if(indexPath.section == 1){
            height = Services.theme.CELLS_HEIGHT + 160
        }
        
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


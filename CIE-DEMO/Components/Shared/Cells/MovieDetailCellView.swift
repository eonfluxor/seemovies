//
//  MovieDetailCellView.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class MovieDetailCellView: UICollectionViewCell {

    var detailView : MovieDetailView!
    var movie : Movie!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        clipsToBounds = true
        
        detailView = MovieDetailView()
        
        addSubview(detailView)
        
        detailView.snp_makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported!")
    }
    
}

extension MovieDetailCellView {
    
    func setupWith(movie: Movie){
        self.movie = movie
        detailView.setupWith(movie: movie)
    }
    
}

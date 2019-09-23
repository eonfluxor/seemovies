//
//  FavButton.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import ChameleonFramework

typealias DidTapFav = ()->Void

class FavButton: UIView {
    
    var movie : Movie!
    var label : UILabel!

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 4
        clipsToBounds = true
        
        
        label = UILabel()
        label.textColor = Services.theme.WHITE
        
        label.font =  Services.theme.H2_FONT_BOLD
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.baselineAdjustment = .alignCenters
        label.text = "Favorite?"
        
        addSubview(label)
        
        label.snp_makeConstraints { (make) in
            make.edges.equalToSuperview().inset(4)
            make.center.equalToSuperview()
        }
        
        ///
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapGesture))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(movie: Movie){
        self.movie = movie
        setNeedsLayout()
        
    }
    
    override func layoutSubviews() {
        updateDisplay()
    }
    
}



extension FavButton {
    
    @objc func didTapGesture(){
        if Services.favs.isFav(movie: movie) {
            Services.flux.dispatch(FluxAction.removeFavorite(movie))
            updateDisplay(force:false)
        } else{
            Services.flux.dispatch(FluxAction.addFavorite(movie))
            updateDisplay(force:true)
        }
       
    }
    
    func updateDisplay(force : Bool? = nil){
        
        guard let movie = self.movie else {
            return
        }
        
        let added = Services.favs.isFav(movie: movie)
        
        if added || force == true {
            backgroundColor = Services.theme.LIGHT_GREY
            label.text = "Favorite"
            label.textColor = Services.theme.DARK_GREY
        } else if !added || force == false {
            
            backgroundColor = .flatOrange
            label.text = "+ Favorite"
            label.textColor = .white
        }
    }
}


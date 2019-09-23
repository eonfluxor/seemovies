//
//  MovieDetailView.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import ChameleonFramework

class MovieDetailView: UIView {
    
    let POSTER_SIZE = 200.0
    let PADDING = Services.theme.PADDING
    
    
    // MODELS
    var movie: Movie!
    
    // UI containers
    
    var headerImage : UIImageView!
    var headerImageOverlay : UIView!
    var infoContainer : UIView!
    
    // UI elements
    
    var poster : PosterView!
    var posterShadow : UIView!
    var titleLabel  : UILabel!
    var genreLabel : UILabel!
    var taglineLabel : UILabel!
    var ratingDisplay : RatingView!
    var overviewLabel : UILabel!
    var favoriteButton : FavButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainers()
        setupInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailView {
    func setupWith(movie: Movie){
        self.movie = movie
        displayCachedInfo()
        displayExtraInfo()
    }
}

extension MovieDetailView {
    
    
    func setupContainers(){
        
        headerImage = UIImageView()
        headerImage.contentMode  = .scaleAspectFill
        
        headerImageOverlay = UIView()
        headerImageOverlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        infoContainer = UIView()
        infoContainer.backgroundColor = Services.theme.LIGHT_GREY
        
        poster = PosterView(frame: .zero)
        poster.layer.cornerRadius = 4
        poster.clipsToBounds = true
        
        posterShadow = UIView()
        posterShadow.layer.shadowColor = UIColor.black.cgColor
        posterShadow.layer.shadowOpacity = 0.6
        posterShadow.layer.shadowOffset = .zero
        posterShadow.layer.shadowRadius = 10
        posterShadow.isUserInteractionEnabled = true
        
        ratingDisplay = RatingView()
        
        favoriteButton = FavButton()
        
        
        addSubview(headerImage)
        addSubview(infoContainer)
        addSubview(posterShadow)
        addSubview(favoriteButton)
        posterShadow.addSubview(poster)
        posterShadow.addSubview(ratingDisplay)
        headerImage.addSubview(headerImageOverlay)
        
        headerImage.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        headerImageOverlay.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        
        infoContainer.snp_makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(snp_bottom).multipliedBy(0.5)
            make.left.equalTo(0)
        }
        
        posterShadow.snp_makeConstraints { (make) in
            make.width.equalTo(POSTER_SIZE * 12.0/16.0)
            make.height.equalTo(POSTER_SIZE )
            make.top.equalTo(snp_bottom).multipliedBy(0.35)
            make.left.equalTo(snp_leftMargin).offset(PADDING)
        }
        
        poster.snp_makeConstraints { (make) in
            make.edges.equalTo(posterShadow)
        }
        
        ratingDisplay.snp_makeConstraints { (make) in
            make.left.equalTo(poster.snp_right).offset(PADDING)
            make.right.equalTo(poster.snp_right).offset(PADDING + 42)
            make.top.equalTo(poster.snp_bottomMargin).inset(PADDING+42)
            make.bottom.equalTo(poster.snp_bottomMargin)
        }
        
        favoriteButton.snp_makeConstraints { (make) in
            make.left.equalTo(poster.snp_right).offset(PADDING)
            make.right.equalTo(poster.snp_right).offset(PADDING + 90)
            make.top.equalTo(poster.snp_topMargin).offset(PADDING)
            make.bottom.equalTo(poster.snp_topMargin).offset(PADDING+30)
        }
        
    }
    
    func setupInfo(){
        
        titleLabel = UILabel()
        titleLabel.textColor = Services.theme.WHITE
        titleLabel.text = "The Martian"
        titleLabel.font =  Services.theme.H1_FONT
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        genreLabel = UILabel()
        genreLabel.textColor = Services.theme.LIGHT_GREY
        genreLabel.text = "Drama, Adventure, Science Fiction"
        genreLabel.font =  Services.theme.H3_FONT
        genreLabel.textAlignment = .center
        genreLabel.adjustsFontSizeToFitWidth = true
        genreLabel.minimumScaleFactor = 0.5
        
        taglineLabel = UILabel()
        taglineLabel.textColor = Services.theme.PRIMARY_COLOR
        taglineLabel.text = "tagline"
        taglineLabel.font =  Services.theme.H2_FONT
        taglineLabel.adjustsFontSizeToFitWidth = true
        taglineLabel.minimumScaleFactor = 0.5
        
        overviewLabel = UILabel()
        overviewLabel.textColor = Services.theme.PRIMARY_COLOR
        overviewLabel.text = "description"
        overviewLabel.font =  Services.theme.DEFAULT_FONT
        overviewLabel.numberOfLines  = -1
        overviewLabel.adjustsFontSizeToFitWidth = true
        overviewLabel.minimumScaleFactor = 0.75
        
        addSubview(titleLabel)
        addSubview(genreLabel)
        
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(snp_bottom).multipliedBy(0.2)
            make.left.equalTo(PADDING)
            make.right.equalTo(self).inset(PADDING)
            make.height.lessThanOrEqualTo(30)
        }
        
        genreLabel.snp_makeConstraints { (make) in
            make.width.equalTo(titleLabel)
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel).offset(30)
            make.height.lessThanOrEqualTo(30)
        }
        
        infoContainer.addSubview(taglineLabel)
        infoContainer.addSubview(overviewLabel)
        
        taglineLabel.snp_makeConstraints { (make) in
          
            make.height.lessThanOrEqualTo(30)
            make.left.equalTo(posterShadow.snp_right).offset(PADDING)
            make.right.equalTo(snp_rightMargin)
            make.top.equalTo(PADDING/2)
        }
        
        overviewLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(snp_leftMargin).offset(PADDING)
            make.right.equalTo(snp_rightMargin).inset(PADDING)
            make.top.equalTo(posterShadow.snp_bottom).offset(PADDING)
            make.bottom.lessThanOrEqualTo(snp_bottom).inset(PADDING)
        }
    }
    
}


extension MovieDetailView {
    
    func displayCachedInfo(){
        if let url =  URL(string:movie.back_url!) {
            headerImage.af_setImage(withURL: url,
                                    placeholderImage: nil,
                                    filter: nil,
                                    imageTransition: .crossDissolve(0.5),
                                    completion: { [weak self] response in
                                        
                                        if let image = response.value {
                                           self?.updatePalette(withImage: image)
                                        }
                                        
            })
            headerImage.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 30) {
                self.headerImage.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
            
        }
        
        if let url =  movie.poster_url {
            poster.displayImage(url)
        }
        
        if let rating = movie.vote_average {
             ratingDisplay.setRating(rating)
        }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.description
        
       
    }
    
    func displayExtraInfo(){
        
        favoriteButton.setupWith(movie: movie)
        
        getExtraInfo { (movie) in
            self.genreLabel.text = movie.genresTitle()
            self.taglineLabel.text = movie.tagline ?? movie.title
        }
        
    }
    
    func getExtraInfo(completion : @escaping MovieClosure )->Void{
        
        guard let mid = movie.id else {
            return
        }
        
        Services.api.get(movieId: mid) { (movie) in
            completion(movie)
        }
    }
    
    func updatePalette(withImage image : UIImage) {
        let avgColor = UIColor.init(averageColorFrom: image)
        let textColor = UIColor(contrastingBlackOrWhiteColorOn: avgColor, isFlat: true)
        
       
        
       UIView.animate(withDuration: 1.0, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState] , animations: {
            self.infoContainer.backgroundColor = avgColor
            self.overviewLabel.textColor = textColor
            self.taglineLabel.textColor = textColor
        })
    }
}


extension MovieDetailView {
    
    
}

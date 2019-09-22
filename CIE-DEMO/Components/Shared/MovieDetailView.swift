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
    let PADDING = 20
    
    
    // MODELS
    var movie: Movie!
    
    // UI containers
    var backdropContainer : UIImageView!
    var backdropContainerPoster : UIImageView!
    var infoContainer : UIView!
    
    // UI elements
    
    var poster : PosterView!
    var posterShadow : UIView!
    var titleLabel  : UILabel!
    var genreLabel : UILabel!
    var headingLabel : UILabel!
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
        
        backdropContainerPoster = UIImageView()
        backdropContainerPoster.contentMode  = .scaleAspectFill
        
        
        backdropContainer = UIImageView()
        backdropContainer.contentMode  = .scaleAspectFill
        
        infoContainer = UIView()
        infoContainer.backgroundColor = Services.theme.LIGHT_GREY
        
        poster = PosterView()
        poster.layer.cornerRadius = 4
        poster.clipsToBounds = true
        
        posterShadow = UIView()
        posterShadow.backgroundColor = .red
        posterShadow.layer.shadowColor = UIColor.black.cgColor
        posterShadow.layer.shadowOpacity = 0.6
        posterShadow.layer.shadowOffset = .zero
        posterShadow.layer.shadowRadius = 10
        posterShadow.isUserInteractionEnabled = true
        
        ratingDisplay = RatingView()
        
        favoriteButton = FavButton()
        
        
        addSubview(backdropContainerPoster)
        addSubview(backdropContainer)
        addSubview(infoContainer)
        addSubview(posterShadow)
        addSubview(favoriteButton)
        posterShadow.addSubview(poster)
        posterShadow.addSubview(ratingDisplay)
        
        
        backdropContainerPoster.snp_makeConstraints { (make) in
            
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        backdropContainer.snp_makeConstraints { (make) in
            
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        infoContainer.snp_makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().inset(Services.theme.HEADER_HEIGHT/2)
            make.top.equalToSuperview().offset(Services.theme.HEADER_HEIGHT)
            make.left.equalTo(0)
        }
        
        posterShadow.snp_makeConstraints { (make) in
            make.width.equalTo(POSTER_SIZE * 12.0/16.0)
            make.height.equalTo(POSTER_SIZE )
            make.top.equalTo(  Double(Services.theme.HEADER_HEIGHT) - (POSTER_SIZE / 2.0) )
            make.left.equalTo(PADDING)
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
        titleLabel.textColor = Services.theme.LIGHT_GREY
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
        
        headingLabel = UILabel()
        headingLabel.textColor = Services.theme.PRIMARY_COLOR
        headingLabel.text = "Bring Him Home"
        headingLabel.font =  Services.theme.H2_FONT
        headingLabel.adjustsFontSizeToFitWidth = true
        headingLabel.minimumScaleFactor = 0.5
        
        overviewLabel = UILabel()
        overviewLabel.textColor = Services.theme.PRIMARY_COLOR
        overviewLabel.text = "Bring Him Home"
        overviewLabel.font =  Services.theme.DEFAULT_FONT
        overviewLabel.numberOfLines  = 7
        
        
        addSubview(titleLabel)
        addSubview(genreLabel)
        
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(Float(PADDING) * 2.5)
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
        
        infoContainer.addSubview(headingLabel)
        infoContainer.addSubview(overviewLabel)
        
        headingLabel.snp_makeConstraints { (make) in
            make.width.equalTo(titleLabel)
            make.height.lessThanOrEqualTo(30)
            make.left.equalTo(titleLabel)
            make.top.equalTo(PADDING)
        }
        
        overviewLabel.snp_makeConstraints { (make) in
            make.width.equalToSuperview().inset(PADDING)
            make.left.equalTo(PADDING)
            make.top.equalTo((POSTER_SIZE / 2.0) + Double(PADDING))
            make.height.equalTo(80)
        }
        
      
        
    }
    
    //    func setup
    
    
}


extension MovieDetailView {
    
    func displayCachedInfo(){
        if let url =  URL(string:movie.poster_url!) {
            backdropContainerPoster.af_setImage(
                withURL: url,
                placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.5),
                completion: { [weak self] response in
                    
                    if let image = response.value {
                        self?.displayOptimalTitleColor(image:image)
                    }
                    
            })
        }
        
        if let url =  movie.poster_url {
            poster.displayImage(url)
        }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.description
        
        
    }
    
    func displayExtraInfo(){
        
        favoriteButton.setupWith(movie: movie)
        
        guard let url =  URL(string:movie.back_url!) else {
            return
        }
        
        backdropContainer.alpha = 0
        backdropContainer.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
        backdropContainer.af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: nil,
            imageTransition: .crossDissolve(0.5),
            completion: { [weak self] response in
                if let image = response.value {
                    self?.displayOptimalTitleColor(image:image)
                }
        })
        
        UIView.animate(withDuration: 0.5, delay: 1, options: [], animations: {
            self.backdropContainer.alpha = 1
            self.backdropContainer.transform = CGAffineTransform.identity
        }, completion:nil);
        
        
    }
}

extension MovieDetailView  {
    
    func displayOptimalTitleColor(image : UIImage){
        
        DispatchQueue.main.async {
            self.titleLabel.textColor = self.constrastingImageColor(image : image)
            self.genreLabel.textColor = self.constrastingImageColor(image : image)
        }
        
    }
    
    func constrastingImageColor(image : UIImage) -> UIColor{
        
        let color = AverageColorFromImage( image)
        let result = UIColor(contrastingBlackOrWhiteColorOn:color, isFlat:false)
        return result
    }
}

extension MovieDetailView {
    
    
}

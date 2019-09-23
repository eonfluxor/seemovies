//
//  MovieViewCell.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import SnapKit

class MovieViewCell: UICollectionViewCell {
    
    let PADDING : CGFloat = 16.0
   
    //refs
    var movie : Movie?
    
    //containers
    var imageContainer : UIView!
    var descContainer : UIView!
    
    //description elements
    var dateLabel : UILabel!
    var titleLabel : UILabel!
    var separator : UIView!
    var descLabel : UILabel!
    var favButton : FavButton!
    var ratingDisplay : RatingView!
    
    //poster
    var posterView : PosterView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupContainers()
        setupDescriptionViews()
        setupImageDisplay()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        descLabel.text = ""
        dateLabel.text = ""
        
        ratingDisplay.setRating(0)
        posterView.displayImage(nil)
        
        self.contentView.backgroundColor = Services.theme.LIGHT_GREY
        self.dateLabel.textColor = Services.theme.BLACK
        self.titleLabel.textColor = Services.theme.BLACK
        self.descLabel.textColor = Services.theme.BLACK
        
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

// public methods
extension MovieViewCell{
    
    func setupWithMovie(_ movie: Movie){
        
        favButton.setupWith(movie: movie)
        
        self.movie = movie
        
        titleLabel.text = movie.title
        descLabel.text = movie.description
        dateLabel.text = movie.release_date_string
        
        if let rating = movie.vote_average {
            ratingDisplay.setRating(rating)
        }
        
        if let poster = movie.poster_url {
            
            posterView.displayImage(poster) { [weak self] image in
                
               
                self?.updatePalette(withImage: image)
            }
        }
        
    }
    
    
}

extension MovieViewCell{
    
    
    func setupContainers(){
        
        imageContainer = UIView()
        descContainer = UIView()
        
        contentView.backgroundColor = Services.theme.WHITE
        contentView.addSubview(imageContainer)
        contentView.addSubview(descContainer)
        contentView.layer.cornerRadius = 2
        contentView.layer.borderColor = Services.theme.MID_GREY.cgColor
        contentView.layer.borderWidth = 1
        
        
        imageContainer.backgroundColor = Services.theme.DARK_GREY
        imageContainer.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(PADDING)
            make.width.equalToSuperview().multipliedBy(0.4).inset(PADDING)
            
            make.top.equalToSuperview().offset(PADDING)
            make.bottom.equalToSuperview().inset(PADDING)
        }
        
        
        descContainer.snp_makeConstraints { (make) in
            make.left.equalTo(imageContainer.snp_right).offset(PADDING)
            make.width.equalToSuperview().multipliedBy(0.6).inset(PADDING/2)
            make.top.equalToSuperview().offset(PADDING)
            make.bottom.equalToSuperview().inset(PADDING)
            
        }
    }
    
    func setupImageDisplay(){
        posterView = PosterView()
        
        imageContainer.addSubview(posterView)
        
        posterView.snp_makeConstraints { (make) in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    func setupDescriptionViews(){
        
        dateLabel = UILabel()
        titleLabel = UILabel()
        separator = UIView()
        descLabel = UILabel()
        favButton = FavButton()
        ratingDisplay = RatingView()
        
        descContainer.addSubview(dateLabel)
        descContainer.addSubview(titleLabel)
        descContainer.addSubview(separator)
        descContainer.addSubview(descLabel)
        descContainer.addSubview(ratingDisplay)
        descContainer.addSubview(favButton)
        
        
        dateLabel.textColor = Services.theme.SECONDARY_COLOR
        dateLabel.text = "October 02, 2015"
        dateLabel.font =  Services.theme.H2_FONT
        
        
        titleLabel.textColor = Services.theme.PRIMARY_COLOR
        titleLabel.text = "The Martian"
        titleLabel.font =  Services.theme.H1_FONT
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        descLabel.textColor = Services.theme.SECONDARY_COLOR
        descLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        descLabel.font =  Services.theme.DEFAULT_FONT
        descLabel.numberOfLines = 2
        
        
        separator.backgroundColor = Services.theme.DARK_GREY
        
        
        dateLabel.snp_makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(20)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp_bottom)
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(30)
        }
        
        separator.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(PADDING/2)
            make.width.equalTo(100)
            make.height.lessThanOrEqualTo(2)
        }
        
        descLabel.snp_makeConstraints { (make) in
            make.top.equalTo(separator.snp_bottom).offset(PADDING/2)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(60)
        }
        
        ratingDisplay.snp_makeConstraints { (make) in
            make.top.equalTo(descLabel.snp_bottom)
            make.left.equalTo(0)
            make.width.equalToSuperview().dividedBy(4)
            make.height.greaterThanOrEqualTo(42)
        }
        
        favButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_rightMargin).inset(120)
            make.right.equalTo(self.snp_rightMargin)
            make.top.equalTo(ratingDisplay.snp_bottom)
            make.height.lessThanOrEqualTo(60)
        }
        
        
    }
    
    
    func updatePalette(withImage image : UIImage) {
        
        DispatchQueue.global(qos: .background).async {
            
            let avgColor = UIColor.init(averageColorFrom: image.af_imageScaled(to: CGSize(width: 50, height: 50)))
            let textColor = UIColor(contrastingBlackOrWhiteColorOn: avgColor, isFlat: true)
            
            DispatchQueue.main.async {
                self.contentView.backgroundColor = avgColor
                self.dateLabel.textColor = textColor
                self.titleLabel.textColor = textColor
                self.descLabel.textColor = textColor
            }
        }
        
    }
    
    
    
}

//
//  DetailController.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/19/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import PINRemoteImage

class DetailViewController: UIViewController {
    
    
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
    var similarLabel : UILabel!
    
    override func viewDidLoad() {
        setupContainers()
        setupInfo()
        
        
    }
    
    func setupEmptyState() {
        
        
        self.view.backgroundColor = Services.theme.LIGHT_GREY
        self.navigationItem.title = "Movie Detail"
        
        // TODO get movie from state
//        if let mov = navInfo?.params?["movie"]! as! Movie? {
//            movie = mov
//        }
        
        DispatchQueue.main.async {
            self.displayEmtpyInfo()
        }
        
        
        
    }
    
    func setupContent() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: Services.theme.WHITE]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = Services.theme.WHITE
        
        
        DispatchQueue.main.async {
            self.displayInfo()
        }
        
//        completionHandle()
    }
    
    
}

extension DetailViewController {
    
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
        posterShadow.layer.shadowOpacity = 1
        posterShadow.layer.shadowOffset = .zero
        posterShadow.layer.shadowRadius = 10
        
        view.addSubview(backdropContainerPoster)
        view.addSubview(backdropContainer)
        view.addSubview(infoContainer)
        view.addSubview(posterShadow)
        posterShadow.addSubview(poster)
        
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
        
        
    }
    
    func setupInfo(){
        
        titleLabel = UILabel()
        titleLabel.textColor = Services.theme.LIGHT_GREY
        titleLabel.text = "The Martian"
        titleLabel.font =  Services.theme.H1_FONT
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        genreLabel = UILabel()
        genreLabel.textColor = Services.theme.LIGHT_GREY
        genreLabel.text = "Drama, Adventure, Science Fiction"
        genreLabel.font =  Services.theme.H3_FONT
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
        
        similarLabel = UILabel()
        similarLabel.textColor = Services.theme.DARK_GREY
        similarLabel.text = "Similar Movies"
        similarLabel.font =  Services.theme.H1_FONT
        
        
        view.addSubview(titleLabel)
        view.addSubview(genreLabel)
        
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(  Double(Services.theme.HEADER_HEIGHT) - (60) )
            make.left.equalTo(posterShadow.snp_right).offset(PADDING)
            make.right.lessThanOrEqualTo(view).inset(PADDING)
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
        infoContainer.addSubview(similarLabel)
        
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
        
        similarLabel.snp_makeConstraints { (make) in
            make.width.equalToSuperview().inset(PADDING)
            make.left.equalTo(PADDING)
            make.top.equalTo(overviewLabel.snp_bottom).offset(PADDING)
            make.height.lessThanOrEqualTo(30)
        }
        
        
    }
}


extension DetailViewController {
    
    func displayEmtpyInfo(){
        if let url =  URL(string:movie.poster_url!) {
            backdropContainerPoster.af_setImage(withURL: url)
        }
        
        if let url =  movie.poster_url {
            poster.displayImage(url)
        }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.description
    }
    
    func displayInfo(){
        
        if let url =  URL(string:movie.back_url!) {
            backdropContainer.alpha = 0
            backdropContainer.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            backdropContainer.af_setImage(withURL: url)
            UIView.animate(withDuration: 0.5, delay: 1, options: [], animations: {
                self.backdropContainer.alpha = 1
                self.backdropContainer.transform = CGAffineTransform.identity
            }, completion:nil);
            
        }
        
        if let url =  movie.poster_url {
            poster.displayImage(url)
        }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.description
        
    }
}

extension DetailViewController {
    
    
}

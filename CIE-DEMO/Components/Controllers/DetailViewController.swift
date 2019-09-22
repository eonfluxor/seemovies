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
    
    var movie : Movie?
    var detailHeader : MovieDetailView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavStyle()
//        displayCachedInfo()
        
//        detailHeader = MovieDetailView()
//        if let movie = movie {
//            detailHeader.setupWith(movie: movie)
//        }
//        
//        view.addSubview(detailHeader)
//        
//        detailHeader.snp_makeConstraints { (make) in
//            make.width.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(2)
//            make.center.equalToSuperview()
//        }
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
}


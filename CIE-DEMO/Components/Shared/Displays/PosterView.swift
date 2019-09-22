//
//  PosterView.swift
//  FlaskNavTests
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import PINCache
import PINRemoteImage

class PosterView: UIImageView {
    
    func displayImage(_ url:String?){
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.image = nil
        
        if let url = url {
            downloadImageAndDisplay(url)
        }
        
        
    }
    
    func downloadImageAndDisplay(_ url:String){
        self.pin_setImage(from: URL(string: url))
    }
    
}

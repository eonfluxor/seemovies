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
    
    func displayImage(_ url:String?, completion:ImageClosure? = nil){
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.image = nil
        
        if let url = url {
            downloadImageAndDisplay(url,completion: completion)
        }
        
        
    }
    
    func downloadImageAndDisplay(_ url:String, completion:ImageClosure? = nil ){
        self.pin_setImage(from: URL(string: url)) { result in
            
            if let image = result.image {
                 completion?(image)
            }
           
        }
    }
    
}

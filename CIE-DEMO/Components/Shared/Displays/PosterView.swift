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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapGesture))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayImage(_ url:String?, completion:ImageClosure? = nil){
        
      
        self.image = nil
        
        if let url = url {
            downloadImageAndDisplay(url,completion: completion)
        } 
        
    }
    
    func downloadImageAndDisplay(_ url:String, completion:ImageClosure? = nil ){
        DispatchQueue.global(qos: .background).async {
            self.pin_setImage(from: URL(string: url)) { result in
                
                if let image = result.image {
                    completion?(image)
                }
                
            }
        }
        
    }
    
}

extension PosterView {
    
    @objc func didTapGesture(){
        
        Services.router.presentImageViewPreview(self)
        
    }
}

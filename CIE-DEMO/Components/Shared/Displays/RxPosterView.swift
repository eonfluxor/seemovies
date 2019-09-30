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
import RxSwift
import RxCocoa

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
    
    func displayImage(_ url:String?, completion:ImageClosureOpt? = nil){
        
        self.image = nil
        
        if let url = url {
            downloadImageAndDisplay(url,completion: completion)
        } 
        
    }
    
    fileprivate func downloadImageAndDisplay(_ url:String, completion:ImageClosureOpt? = nil ){
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

extension Reactive where Base:PosterView{
    var imageURL: Binder<String?> {
        return Binder(self.base) { view, url in
            view.displayImage(url)
        }
    }
    
    func displayImage(withUrl url: String) -> Single<UIImage> {
        return Single<UIImage>.create { single in
            
            self.base.displayImage(url){ image in
                if let image = image {
                    single(.success(image))
                }else{
                    single(.error(NSError(domain: "network error", code: 0, userInfo: ["url":url])))
                }
            }
            
            return Disposables.create()
        }
    }
}

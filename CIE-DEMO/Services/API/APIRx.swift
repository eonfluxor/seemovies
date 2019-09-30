//
//  APIRx.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/30/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import AlamofireObjectMapper


extension Reactive where Base:APIService{
    
    func call<K>(_ endpoint : APIEndpoints) -> Single<K> {
        return Single<K>.create { single in
            
            let finish:(K?)->Void = { response in
                guard let resource = response  else {
                    assert(false, "Unexpected response format")
                    single(.error(Services.error.type(.networkFailure)))
                }
                
                DispatchQueue.main.async {
                    single(.success(resource))
                }
            }
            
            switch endpoint{
            case .getMovie:
                APIService
                    .getMovie(endpoint.url()
                        ,completion: finish as! APIResourceClosure<Movie>)
                
            case .getMovieRelated:
                APIService
                    .getMovies(endpoint.url()
                        ,completion: finish as! APIResourceClosure<[Movie]>)
                
                
            case .getTrendingMovies:
                APIService
                    .getMovies(endpoint.url()
                        ,completion: finish as! APIResourceClosure<[Movie]>)
                
                break
            }
            
            return Disposables.create()
        }
    }
    
  
}





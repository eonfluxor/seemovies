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
    
    func call<K>(_ endpoint : APIEndpointName) -> Single<K> {
        return Single<K>.create { single in
            
            let finish:(K?)->Void = { response in
                guard let resource = response  else {
                    assert(false, "Unexepcted response format")
                    single(.error(Services.error.type(.networkFailure)))
                }
                
                DispatchQueue.main.async {
                    single(.success(resource))
                }
            }
            
            switch endpoint{
            case .getMovie(let movieId):
                APIService
                    .getMovie(APIEndpoints.movieInfo(movieId:movieId)
                        ,completion: finish as! APIResourceClosure<Movie>)
                
            case .getMovieRelated(let movieId):
                APIService
                    .getMovies(APIEndpoints.similarMovies(movieId:movieId)
                        ,completion: finish as! APIResourceClosure<[Movie]>)
                
                
            case .getTrendingMovies(let page):
                APIService
                    .getMovies(APIEndpoints.trendingMovies(page:page)
                        ,completion: finish as! APIResourceClosure<[Movie]>)
                
                break
            }
            
            
            return Disposables.create()
        }
    }
    
  
}





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
    
    func call<K:APIResponse>(_ endpoint : APIEndpoints) -> Single<K> {
        return Single<K>.create { single in
            
            let finish:APIClosure<K> = { response in
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
                    .get(endpoint,completion: finish as! APIClosure<Movie>)
                
            case .getMovieRelated, .getTrendingMovies:
                APIService
                    .get(endpoint,completion: finish as! APIClosure<APIResponseMovieList>)
                
            }
            
            return Disposables.create()
        }
    }
    
}





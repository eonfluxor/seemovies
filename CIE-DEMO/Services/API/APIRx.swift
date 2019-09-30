//
//  APIRx.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/30/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import RxSwift


extension Reactive where Base:APIService{
    
    func resource(_ endpoint : APIEndpointName) -> Single<Movie> {
        return Single<Movie>.create { single in
            
            switch endpoint{
            case .getMovie(let movieId):
                
                self.base.get(movieId: movieId){ movie in
                    if let movie = movie {
                        single(.success(movie))
                    }else{
                        single(.error(Services.error.message("foo")))
                    }
                }
                
            default:
                break
            }
            
            return Disposables.create()
        }
    }
    
    func list(_ endpoint : APIEndpointName) -> Single<[Movie]> {
        return Single<[Movie]>.create { single in
            
            switch endpoint{
            
                
            case .getMovieRelated(let movieId):
                
                self.base.getSimilarTo(movieId: movieId){ movies in
                    if let movies = movies {
                        single(.success(movies))
                    }else{
                        single(.error(Services.error.type(.networkFailure)))
                    }
                }
                
                
            case .getTrendingMovies(let page):
               
                self.base.getMoviesList(from: page){ movies in
                    if let movies = movies {
                        single(.success(movies))
                    }else{
                        single(.error(Services.error.type(.networkFailure)))
                    }
                }
                
            default:
                break
            }
            
            return Disposables.create()
        }
    }
}

//
//  APIService.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

typealias APIMovieListCompletion = ([Movie])->Void
typealias APIMovieCompletion = (Movie)->Void


class APIService: NSObject {
    
    //TODO: Revoke and read from external (non-github) file (maybe git-crypt)
    static let API_KEY_V3 = "43af0066f64198f00c8d98d9d347b31f"
    
    func endpoint(_ url:String)->String{
        return "\(url)?api_key=\(APIService.API_KEY_V3)"
    }
    
    func getMoviesList(from page:Int? = nil, _ completion:@escaping APIMovieListCompletion)->Void{
        //make api request and map
        
        
        Alamofire.request(endpoint(APIEndpoints.trendingMovies)).responseObject { (response: DataResponse<APIResponseMovieList>) in
            
            let response = response.result.value
            
            DispatchQueue.main.async {
                completion(response?.results ?? []);
            }
            
            //            let weatherResponse = response.result.value
            //            print(weatherResponse?.location)
            //
            //            if let threeDayForecast = weatherResponse?.threeDayForecast {
            //                for forecast in threeDayForecast {
            //                    print(forecast.day)
            //                    print(forecast.temperature)
            //                }
            //            }
        }
        
        
        
    }
    
}

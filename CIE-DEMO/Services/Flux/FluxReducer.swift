//
//  FluxReducer.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import ReSwift


func FluxReducer(action: Action, state: FluxState?) -> FluxState {
    
    var state = state ?? FluxState()
    
    guard let action = action as? FluxAction else {
        return state
    }
    
    switch action {
    case .addFavorite(let movie):
        if let id = movie.id {
            state.favs[id] = movie
        }
        break
    case .removeFavorite(let movie):
        if let id = movie.id {
            state.favs.removeValue(forKey: id)
        }
        break
        
    }
    
    FluxPersistIntent()
    
    return state
}

//
//  FluxStore.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var favs : [String:Movie] = [:]
}

// This action does not have state and is a mere marker of "X happened":
struct AddAction: Action { }

func appReducer(action: Action, state: AppState?) -> AppState {
    
    var state = state ?? AppState()
    
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
        
//    default: break
    }
    
    return state
}

let fluxStore = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: [])

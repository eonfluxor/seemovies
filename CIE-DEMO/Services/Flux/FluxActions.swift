//
//  FluxActions.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import ReSwift

enum FluxAction: Action {
    case addFavorite(Movie)
    case removeFavorite(Movie)
}

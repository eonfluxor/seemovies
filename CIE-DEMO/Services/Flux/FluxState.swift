//
//  FluxState.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import ReSwift

struct FluxState: StateType, Codable {
    var favs : [String:Movie] = [:]
}

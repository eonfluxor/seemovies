//
//  FluxStore.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import ReSwift

let fluxStore = Store(
    reducer: FluxReducer,
    state: FluxUnarchive(),
    middleware: [])

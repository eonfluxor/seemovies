//
//  FluxPersist.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import Delayed

let FLUX_ARCHIVE_KEY = "FLUX_ARCHIVE_KEY.v1.0.1"

func FluxPersistIntent(){
    
    Kron.debounceLast(timeOut: 1.0, resetKey: "fluxStore") { (key, ctx) in
      FluxArchive()
    }
}

func FluxArchive() {
    let state = Services.flux.state!
    guard let data = try? Services.codable.dataFromState(state) else{
        return
    }
    UserDefaults.standard.set(data,forKey: FLUX_ARCHIVE_KEY )
    UserDefaults.standard.synchronize()
}

func FluxUnarchive()->FluxState {
    guard let data = UserDefaults.standard.value(forKey: FLUX_ARCHIVE_KEY) else {
        return FluxState()
    }
    
    guard let state = try? Services.codable.stateFromData(data as! Data)  else{
        return FluxState()
    }
    
    return state
}

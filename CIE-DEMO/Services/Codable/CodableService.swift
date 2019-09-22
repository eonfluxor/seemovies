//
//  CodableService.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class CodableService: NSObject {

    func jsonFromState(_ state:FluxState) throws ->String {
        
        let jsonData = try JSONEncoder().encode(state)
        
        return String(data: jsonData, encoding: .utf8)!
        
    }
    
    func stateFromJson(_ json:String) throws ->FluxState {
        
        let jsonData = json.data(using: .utf8)!
        return try stateFromData(jsonData)
    }
    
    
    func dataFromState(_ state:FluxState) throws ->Data? {
        
        let json = try jsonFromState(state)
        return json.data(using: .utf16)
    }
    
    func stateFromData(_ jsonData:Data) throws ->FluxState {
        
        let state:FluxState = try! JSONDecoder().decode(FluxState.self, from: jsonData)
        return state
    }
}

//
//  ErrorsService.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/30/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

enum CommonErrors:String{
    case networkFailure
}

class ErrorsService: NSObject {

    func message(_ message:String) -> NSError {
        return NSError(domain: "Unspecific", code: 0, userInfo: ["message":message])
    }
    
    func type(_ type:CommonErrors) -> NSError {
        return NSError(domain: "Unspecific", code: 0, userInfo: ["message":type.rawValue])
    }
}

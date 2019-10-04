//
//  RxUI.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 10/4/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class UIRelay<Element>: NSObject {
    
    var behavior: BehaviorRelay<Element>!
    var driver: Driver<Element> {
        return behavior.asDriver()
    }

    public init(value: Element) {
       behavior =  BehaviorRelay<Element>(value: value)
    }
    
    public func value()->Element {
        return behavior.value
    }
    
    public func accept(_ event: Element) {
        behavior.accept(event)
    }
}

//
//  MoviesSection.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/29/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import RxDataSources

struct MoviesSection {
    var header:String
    var items:[Item]
    var uniqueId: String = "Trending"
}

extension MoviesSection: AnimatableSectionModelType{
    
    typealias Item = Movie
    typealias Identity = String
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
    
    init(original: MoviesSection, items: [Item]) {
        self = original
        self.items = items
    }
    var identity: String {
        return uniqueId
    }
}


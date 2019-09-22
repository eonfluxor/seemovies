//
//  Services.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/15/18.
//  Copyright © 2018 eonflux. All rights reserved.
//

import UIKit
import AlamofireImage

class Services {
    static let router = RouterService()
    static let api = APIService()
    static let theme = ThemeService.self
    static let flux = fluxStore
    static let favs = FavoritesService()
    static let codable = CodableService()
}

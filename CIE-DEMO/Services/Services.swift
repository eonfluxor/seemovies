//
//  Services.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/15/18.
//  Copyright © 2018 eonflux. All rights reserved.
//

import UIKit
import AlamofireImage

typealias MovieClosure = (Movie)->Void
typealias ImageClosure = (UIImage)->Void
typealias ImageClosureOpt = (UIImage?)->Void

class Services {
    static let router = RouterService()
    static let api = APIService()
    static let theme = ThemeService.self
    static let flux = fluxStore
    static let favs = FavoritesService()
    static let codable = CodableService()
}

func uniq<S: Sequence, E: Hashable>(_ source: S) -> [E] where E == S.Iterator.Element {
    var seen = Set<E>()
    return source.filter { seen.update(with: $0) == nil }
}

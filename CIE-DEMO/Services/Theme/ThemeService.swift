//
//  ThemeService.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class ThemeService: NSObject {
    
    
    static let CELLS_HEIGHT = 222
    static let FONT_FAMILY = "HelveticaNeue"
    
    static let H1_FONT = UIFont(name: "\(FONT_FAMILY)-Bold", size: 22)
    static let H2_FONT_BOLD = UIFont(name: "\(FONT_FAMILY)-Bold", size: 16)
    static let H2_FONT = UIFont(name: "\(FONT_FAMILY)-Light", size: 16)
    static let H3_FONT = UIFont(name: FONT_FAMILY, size: 12)
    static let H4_FONT = UIFont(name: FONT_FAMILY, size: 8)
    static let DEFAULT_FONT = UIFont(name: FONT_FAMILY, size: 14)
    static let LINK_ATTRIBUTES : [NSAttributedString.Key: Any] = [
        .font:  UIFont(name: FONT_FAMILY, size: 12)!,
        .foregroundColor: UIColor.blue,
        .underlineStyle : 1  //Should be this but it's failing: NSUnderlineStyle.styleSingle
    ]
    
    
    static let LIGHT_GREY = UIColor(red: 235 , green: 235 , blue: 235 )
    static let MID_GREY = UIColor(red: 200 , green: 200 , blue: 200 )
    static let DARK_GREY = UIColor(red: 130 , green: 130 , blue: 130 )
    static let WHITE = UIColor.white
    static let YELLOW = UIColor(red: 250, green: 200, blue: 50)
    static let BLACK = UIColor(red: 40, green: 40, blue: 40)
    
    static let PRIMARY_COLOR = BLACK
    static let SECONDARY_COLOR = DARK_GREY
    
}




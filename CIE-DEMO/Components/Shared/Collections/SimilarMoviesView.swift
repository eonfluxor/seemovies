//
//  SimilarMoviesView.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class SimilarMoviesView: UIView {

    let PADDING = Services.theme.PADDING
    
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = Services.theme.LIGHT_GREY
        
        titleLabel = UILabel()
        titleLabel.textColor = Services.theme.BLACK
        titleLabel.text = "Similar Movies"
        titleLabel.font =  Services.theme.H1_FONT
        titleLabel.textAlignment = .left
        
        addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_leftMargin)
            make.right.equalTo(self.snp_rightMargin)
            make.height.lessThanOrEqualTo(30)
            make.top.lessThanOrEqualTo(PADDING)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

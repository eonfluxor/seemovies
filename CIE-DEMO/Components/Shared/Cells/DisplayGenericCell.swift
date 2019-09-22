//
//  DisplayGenericCell.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/22/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class DisplayGenericCell< DISPLAY_VIEW :UIView> : UICollectionViewCell {

    var displayView : DISPLAY_VIEW!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        clipsToBounds = true
        
        displayView = DISPLAY_VIEW()
        
        addSubview(displayView)
        
        displayView.snp_makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported!")
    }
    
}

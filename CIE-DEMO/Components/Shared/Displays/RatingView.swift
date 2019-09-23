//
//  RatingView.swift
//  FlaskNav
//
//  Created by hassan uriostegui on 9/20/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    var label : UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        label = UILabel()
        label.textColor = Services.theme.PRIMARY_COLOR
        label.text = "N/A"
        label.font =  Services.theme.H2_FONT_BOLD
        label.textAlignment = .center
        
        addSubview(label)
        
        label.snp_makeConstraints { (make) in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            
            // Set the circle outerline-width
            context.setLineWidth(5.0);
            
            // Set the circle outerline-colour
            Services.theme.YELLOW.set()
            
            // Create Circle
            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            
            let diameter =   rect.height > rect.width ? rect.width : rect.height
            context.addArc(center: center, radius: diameter/2, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
            
            // Draw
            context.fillPath()
        }
    }
}

extension RatingView {
    
    func  setRating(_ rating:Float){
        if rating < 0.5 {
            label.text = "N/A"
        }else{
            label.text = String(format:"%.1f",rating)
        }
        
    }
}

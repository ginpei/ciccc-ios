//
//  MyScrollView.swift
//  assignment07-MyScrollView
//
//  Created by Ginpei on 2017-06-09.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class MyScrollView: UIView {
    var minY: CGFloat = 0.0
    let maxY: CGFloat = 0.0
    var currentY: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let r = UIPanGestureRecognizer(target: self, action: #selector(onpan))
        addGestureRecognizer(r)
    }
    
    func updateSize() {
        var maxBottom: CGFloat = 0.0
        for v in subviews {
            let bottom = v.frame.origin.y + v.frame.size.height
            if (bottom > maxBottom) {
                maxBottom = bottom
            }
        }
        
        let parentHeight = superview?.frame.size.height ?? CGFloat(0.0)
        
        frame.size.height = maxBottom
        minY = -(maxBottom - parentHeight)
    }
    
    func onpan(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self)
        let y = calculateProperY(currentY + point.y)
        frame.origin.y = y
        
        if (sender.state == UIGestureRecognizerState.ended) {
            currentY = y
        }
    }
    
    func calculateProperY(_ y: CGFloat) -> CGFloat {
        if y > maxY {
            return maxY
        }
        else if y < minY {
            return minY
        }
        else {
            return y
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

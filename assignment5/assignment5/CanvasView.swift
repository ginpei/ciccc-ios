//
//  CanvasView.swift
//  assignment5
//
//  Created by Ginpei on 2017-06-08.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var color = UIColor.black.cgColor
    var strokeWidth = 10
    var strokes = [Stroke]()
    var currentStroke:Stroke!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        currentStroke = Stroke(color: color)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            currentStroke = Stroke(color: color)
            currentStroke.appendPoint(point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            currentStroke.appendPoint(touch.location(in: self))
            setNeedsDisplay()  // to invoke draw(_)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        strokes.append(currentStroke)
    }

    override func draw(_ rect: CGRect) {
        if (strokes.count < 1 && currentStroke.points.count < 1) {
            return
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            for stroke in strokes {
                stroke.draw(on: context)
            }
            
            currentStroke.draw(on: context)
        }
    }
    
    class Stroke {
        let color:CGColor
        var points:[CGPoint] = []
        
        init(color: CGColor) {
            self.color = color
        }
        
        func appendPoint(_ point: CGPoint) {
            points.append(point)
        }
        
        
        func draw(on context: CGContext) {
            context.beginPath()
            
            context.move(to: points[0])
            for point in points {
                context.addLine(to: point)
                context.move(to: point)
            }
            
            context.setStrokeColor(color)
            context.strokePath()
        }
    }
}

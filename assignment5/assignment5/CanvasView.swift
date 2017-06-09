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
    var strokeWidth = 1.0
    var strokes = [Stroke]()
    var currentStroke:Stroke!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        currentStroke = Stroke(color: color, width: strokeWidth)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            currentStroke = Stroke(color: color, width: strokeWidth)
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
        let maxDistance = 100.0
        
        let color:CGColor
        var strokeWidth:Double
        var points:[CGPoint] = []
        
        init(color: CGColor, width: Double) {
            self.color = color
            strokeWidth = width
        }
        
        func appendPoint(_ point: CGPoint) {
            points.append(point)
        }
        
        func draw(on context: CGContext) {
            context.beginPath()
            
            context.setStrokeColor(color)
            context.setLineCap(CGLineCap.round)
            context.setLineJoin(CGLineJoin.round)
            
            var last = points[0]
            context.move(to: last)
            for point in points {
                
                let distance = Double(abs(point.x - last.x) + abs(point.y - last.y))
                let speedRate = max(0.5, min(1, distance / maxDistance))
                let width = strokeWidth * speedRate
                
                context.addLine(to: point)
                context.setLineWidth(CGFloat(width))
                context.strokePath()
                
                last = point
                context.move(to: last)
            }
        }
    }
}

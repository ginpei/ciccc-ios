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
    var lines = [Line]()
    var currentLine:Line!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        currentLine = Line(color: color)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            currentLine = Line(color: color)
            currentLine.appendPoint(point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            currentLine.appendPoint(touch.location(in: self))
            setNeedsDisplay()  // to invoke draw(_)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end")
        lines.append(currentLine)
    }

    override func draw(_ rect: CGRect) {
        if (lines.count < 1 && currentLine.points.count < 1) {
            return
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            print("lines: \(lines.count)")
            for line in lines {
                line.draw(on: context)
            }
            
            currentLine.draw(on: context)
        }
    }
    
    class Line {
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

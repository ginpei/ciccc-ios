//
//  CanvasView.swift
//  assignment5
//
//  Created by Ginpei on 2017-06-08.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var lines = [[CGPoint]]()
    var points = [CGPoint]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            points.append(touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            points.append(touch.location(in: self))
            setNeedsDisplay()  // to invoke draw(_)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end")
        lines.append(points)
        points = []
    }

    override func draw(_ rect: CGRect) {
        if (lines.count < 1 && points.count < 1) {
            return
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            print("lines: \(lines.count)")
            for line in lines {
                print("points in a line: \(line.count)")
                drawLine(line, on: context)
            }
            
            drawLine(points, on: context)
        }
    }
    
    func drawLine(_ points: [CGPoint], on context: CGContext) {
        context.beginPath()
        
        context.move(to: points[0])
        for point in points {
            context.addLine(to: point)
            context.move(to: point)
        }
        
        context.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.strokePath()
    }
}

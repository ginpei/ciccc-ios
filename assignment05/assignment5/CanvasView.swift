//
//  CanvasView.swift
//  assignment5
//
//  Created by Ginpei on 2017-06-08.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class CanvasView: UIView, UITextFieldDelegate {
    static let firstColorIndex = 0
    static let colors = [
        Color.black,
        Color.white,
        Color.red,
        Color.green,
        Color.blue,
        Color.yellow,
        Color.orange,
        Color.purple,
    ]
    static let firstStrokeWidthIndex = 4
    static let strokeWidths = [1.0, 3.0, 5.0, 7.0, 10.0, 15.0, 20.0]
    
    var color = CanvasView.colors[CanvasView.firstColorIndex].cgColor
    var strokeWidth = CanvasView.strokeWidths[CanvasView.firstStrokeWidthIndex]
    var contents = [Content]()
    var currentStroke: Stroke!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        currentStroke = Stroke(color: color, size: strokeWidth)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ontap))
        tapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            currentStroke = Stroke(color: color, size: strokeWidth)
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
        if let touch = touches.first {
            currentStroke.appendPoint(touch.location(in: self))
            setNeedsDisplay()  // to invoke draw(_)
        }
        
        contents.append(currentStroke)
    }

    override func draw(_ rect: CGRect) {
        if (contents.count < 1 && currentStroke.points.count < 1) {
            return
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            for stroke in contents {
                stroke.draw(on: context)
            }
            
            currentStroke.draw(on: context)
        }
    }
    
    func ontap(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        let textField = createTextField(at: point)
        addSubview(textField)
        textField.becomeFirstResponder()
    }
    
    func createTextField(at point: CGPoint) -> UITextField {
        let height = strokeWidth * 3
        let rect = CGRect(x: Double(point.x) - height / 2, y: Double(point.y) - height / 2, width: height * 10, height: height)
        let textField = UITextField(frame: rect)
        
        textField.textColor = UIColor(cgColor: color)
        textField.minimumFontSize = CGFloat(strokeWidth)
        textField.borderStyle = UITextBorderStyle.roundedRect
        
        textField.delegate = self
        
        return textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print(text)
            contents.append(Text(text, at: textField.frame, color: color, size: strokeWidth))
            setNeedsDisplay()  // to invoke draw(_)
        }
        
        textField.removeFromSuperview()
    }
    
    struct Color {
        static let black = Color(name: "Black", cgColor: UIColor.black.cgColor)
        static let white = Color(name: "White (Eraser)", cgColor: UIColor.white.cgColor)
        static let red = Color(name: "Red", cgColor: UIColor.red.cgColor)
        static let green = Color(name: "Green", cgColor: UIColor.green.cgColor)
        static let blue = Color(name: "Blue", cgColor: UIColor.blue.cgColor)
        static let yellow = Color(name: "Yellow", cgColor: UIColor.yellow.cgColor)
        static let orange = Color(name: "Orange", cgColor: UIColor.orange.cgColor)
        static let purple = Color(name: "Purple", cgColor: UIColor.purple.cgColor)
        
        let name: String
        let cgColor: CGColor
        
        init(name: String, cgColor: CGColor) {
            self.name = name
            self.cgColor = cgColor
        }
    }
    
    class Content {
        let color: CGColor
        let size: Double
        
        init(color: CGColor, size: Double) {
            self.color = color
            self.size = size
        }

        func draw(on context: CGContext) {
            // implement me!
        }
    }
    
    class Stroke: Content {
        let maxDistance = 300.0
        
        var points: [CGPoint] = []
        
        func appendPoint(_ point: CGPoint) {
            points.append(point)
        }
        
        override func draw(on context: CGContext) {
            context.beginPath()
            
            context.setStrokeColor(color)
            context.setLineCap(CGLineCap.round)
            context.setLineJoin(CGLineJoin.round)
            
            var last = points[0]
            var distances = [0.0, 0.0, 0.0]
            context.move(to: last)
            for point in points {
                
                let distance = Double(abs(point.x - last.x) + abs(point.y - last.y))
                let longDistance = distance + distances.reduce(0, +)
                let speedRate = max(0.5, min(1, longDistance / maxDistance))
                let width = size * speedRate
                
                context.addLine(to: point)
                context.setLineWidth(CGFloat(width))
                context.strokePath()
                
                last = point
                context.move(to: last)
                distances[2] = distances[1]
                distances[1] = distances[0]
                distances[0] = distance
            }
        }
    }
    
    class Text: Content {
        let string: String
        let frame: CGRect
        
        init(_ string: String, at frame: CGRect, color: CGColor, size: Double) {
            self.string = string
            self.frame = frame
            super.init(color: color, size: size)
        }
        
        override func draw(on context: CGContext) {
            let attr = [
                "NSForegroundColorAttributeName": UIColor(cgColor: color),
                "NSFontAttributeName": UIFont.systemFont(ofSize: CGFloat(size)),
                ]
            string.draw(in: frame, withAttributes: attr)
        }
    }
}

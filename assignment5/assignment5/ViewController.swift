//
//  ViewController.swift
//  assignment5
//
//  Created by Ginpei on 2017-06-08.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var colorPickerView: UIPickerView!
    @IBOutlet weak var strokeWidthPickerView: UIPickerView!
    
    let colors = [
        ["Black", UIColor.black.cgColor],
        ["Red", UIColor.red.cgColor],
    ]
    let strokeWidths = [1.0, 2.0, 3.0, 5.0, 7.0, 10.0, 15.0, 20.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.dataSource = self
        colorPickerView.delegate = self
        pickerView(colorPickerView, didSelectRow: 0, inComponent: 0)
        
        strokeWidthPickerView.dataSource = self
        strokeWidthPickerView.delegate = self
        pickerView(strokeWidthPickerView, didSelectRow: 0, inComponent: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView == colorPickerView) {
            return 1
        }
        else if (pickerView == strokeWidthPickerView) {
            return 1
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == colorPickerView) {
            return colors.count
        }
        else if (pickerView == strokeWidthPickerView) {
            return strokeWidths.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == colorPickerView) {
            return colors[row][0] as? String
        }
        else if (pickerView == strokeWidthPickerView) {
            return "\(strokeWidths[row])"
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == colorPickerView) {
            canvasView.color = colors[row][1] as! CGColor
        }
        else if (pickerView == strokeWidthPickerView) {
            canvasView.strokeWidth = strokeWidths[row]
        }
    }
}


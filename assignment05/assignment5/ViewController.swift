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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.dataSource = self
        colorPickerView.delegate = self
        colorPickerView.selectRow(CanvasView.firstColorIndex, inComponent: 0, animated: false)
        
        strokeWidthPickerView.dataSource = self
        strokeWidthPickerView.delegate = self
        strokeWidthPickerView.selectRow(CanvasView.firstStrokeWidthIndex, inComponent: 0, animated: false)
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
            return CanvasView.colors.count
        }
        else if (pickerView == strokeWidthPickerView) {
            return CanvasView.strokeWidths.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == colorPickerView) {
            return CanvasView.colors[row].name
        }
        else if (pickerView == strokeWidthPickerView) {
            return "\(CanvasView.strokeWidths[row])"
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == colorPickerView) {
            canvasView.color = CanvasView.colors[row].cgColor
        }
        else if (pickerView == strokeWidthPickerView) {
            canvasView.strokeWidth = CanvasView.strokeWidths[row]
        }
    }
}


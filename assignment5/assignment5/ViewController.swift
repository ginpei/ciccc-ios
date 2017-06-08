//
//  ViewController.swift
//  assignment5
//
//  Created by Ginpei on 2017-06-08.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var colorPickerView: UIPickerView!
    @IBOutlet weak var strokeWidthPickerView: UIPickerView!
    
    let colors = ["Black", "Red"]
    let strokeWidths = [10, 20]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.dataSource = self
        colorPickerView.delegate = self
        
        strokeWidthPickerView.dataSource = self
        strokeWidthPickerView.delegate = self
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
        print("\(pickerView == colorPickerView), \(row), \(component)")
        if (pickerView == colorPickerView) {
            return colors[row]
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
            print("color: \(colors[row])")
        }
        else if (pickerView == strokeWidthPickerView) {
            print("stroke width: \(strokeWidths[row])")
        }
    }
}


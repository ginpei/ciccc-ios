//
//  ViewController.swift
//  Assignment06-TipCalc
//
//  Created by Ginpei on 2017-06-09.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipInPercentageView: UIView!
    @IBOutlet weak var tipInPercentageTextField: UITextField!
    @IBOutlet weak var tipInPercentageSlider: UISlider!
    @IBOutlet weak var tipInDollarsView: UIView!
    @IBOutlet weak var tipInDollarsTextField: UITextField!
    @IBOutlet weak var tipInPercentageForDallarsLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    let tipCalculation = TipCalculation(billAmount: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCalculation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCalculation() {
        billAmountTextField.text = String(tipCalculation.billAmount)
        tipInPercentageTextField.text = String(tipCalculation.tipInPercentage)
        tipInDollarsTextField.text = String(tipCalculation.tipInDollars)
        calculationLabel.text = "$ \(tipCalculation.billAmount) + $\(tipCalculation.tipInDollars)"
        resultLabel.text = "$ \(tipCalculation.billAmount + tipCalculation.tipInDollars)"
    }

    @IBAction func billAmountTextField_editingDidEnd(_ sender: Any) {
        tipCalculation.billAmount = Double(billAmountTextField.text!)!
        updateCalculation()
    }

    @IBAction func toggleTipInPercentage_valueChanged(_ sender: Any) {
        let turnedOn = (sender as! UISwitch).isOn
        
        tipCalculation.payInPercentage = turnedOn
        
        tipInPercentageView.isHidden = !turnedOn
        tipInDollarsView.isHidden = turnedOn
    }
    
    @IBAction func tipInPercentageTextField_editingDidEnd(_ sender: Any) {
        tipCalculation.tipInPercentage = Int(tipInPercentageTextField.text!)!
        updateCalculation()
    }
    
    @IBAction func tipInPercentageSlider_valueChanged(_ sender: Any) {
        print("tip in % slider")
    }
    
    @IBAction func tipInDollarsTextField_editingDidEnd(_ sender: Any) {
        tipCalculation.tipInDollars = Double(tipInDollarsTextField.text!)!
        updateCalculation()
    }
    
    @IBAction func set10percent_touchUpInside(_ sender: Any) {
        tipCalculation.tipInPercentage = 10
        updateCalculation()
    }
    
    @IBAction func set15percent_touchUpInside(_ sender: Any) {
        tipCalculation.tipInPercentage = 15
        updateCalculation()
    }
    
    @IBAction func set20percent_touchUpInside(_ sender: Any) {
        tipCalculation.tipInPercentage = 20
        updateCalculation()
    }
}


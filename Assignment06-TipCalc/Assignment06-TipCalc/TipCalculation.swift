//
//  TipCalculation.swift
//  Assignment06-TipCalc
//
//  Created by Ginpei on 2017-06-09.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

class TipCalculation {
    var billAmount = 0.0
    var _tipInPercentage = 0
    var _tipInDollars = 0.0
    var payInPercentage = true
    
    init(billAmount: Double) {
        self.billAmount = billAmount
    }
    
    var tipInPercentage: Int {
        get {
            if payInPercentage {
                return _tipInPercentage
            }
            else {
                return Int(100 * _tipInDollars / billAmount)
            }
        }
        set(value) {
            if payInPercentage {
                _tipInPercentage = value
            }
            else {
                _tipInDollars = billAmount * Double(value) / 100
            }
        }
    }
    
    var tipInDollars: Double {
        get {
            if !payInPercentage {
                return _tipInDollars
            }
            else {
                return billAmount * Double(_tipInPercentage) / 100
            }
        }
        set(value) {
            if !payInPercentage {
                _tipInDollars = value
            }
            else {
                _tipInPercentage = Int(100 * value / billAmount)
            }
        }
    }
}

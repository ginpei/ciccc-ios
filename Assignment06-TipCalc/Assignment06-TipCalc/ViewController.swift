//
//  ViewController.swift
//  Assignment06-TipCalc
//
//  Created by Ginpei on 2017-06-09.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipInPercentageView: UIView!
    @IBOutlet weak var tipInDollarsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func toggleTipInPercentage_valueChanged(_ sender: Any) {
        let turnedOn = (sender as! UISwitch).isOn
        tipInPercentageView.isHidden = !turnedOn
        tipInDollarsView.isHidden = turnedOn
    }
}


//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Ginpei on 2017-06-06.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mySwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isOn = UserDefaults.standard.value(forKey: "isOn") as? Bool {
            toggleBgColor(isOn)
            mySwitch.setOn(isOn, animated: false)
        }
        else {
            toggleBgColor(false)
            mySwitch.setOn(false, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchChanged(_ sender: Any) {
        toggleBgColor(mySwitch.isOn)
        
        UserDefaults.standard.set(mySwitch.isOn, forKey: "isOn")
    }
    
    func toggleBgColor(_ isOn: Bool) {
        if isOn {
            view.backgroundColor = UIColor.blue
        }
        else {
            view.backgroundColor = UIColor.orange
        }
    }
}


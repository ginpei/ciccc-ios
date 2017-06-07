//
//  ViewController.swift
//  PastelDemo
//
//  Created by Ginpei on 2017-06-07.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Pastel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pastelView1 = PastelView(frame: view.bounds)
        pastelView1.startAnimation()
        view.insertSubview(pastelView1, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


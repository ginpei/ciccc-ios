//
//  ViewController.swift
//  assignment07-MyScrollView
//
//  Created by Ginpei on 2017-06-09.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myScrollView: MyScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myScrollView.frame.origin.y = -100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


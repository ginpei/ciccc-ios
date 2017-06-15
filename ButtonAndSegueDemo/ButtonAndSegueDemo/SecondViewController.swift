//
//  SecondViewController.swift
//  ButtonAndSegueDemo
//
//  Created by Ginpei on 2017-06-15.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissThisVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

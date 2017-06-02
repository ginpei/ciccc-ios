//
//  ViewController.swift
//  WeatherApp
//
//  Created by Derrick Park on 2017-05-26.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let city: City
    
    init(city: City) {
        super.init()
        self.city = city
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.orange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


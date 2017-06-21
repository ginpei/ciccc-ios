//
//  ViewController.swift
//  TimerDemo
//
//  Created by Ginpei on 2017-06-21.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var startedAt: Date? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start() {
        startedAt = Date()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timer_tick), userInfo: nil, repeats: true)
    }

    @IBAction func startButton_touchUpInside(_ sender: Any) {
        start()
    }
    
    func timer_tick() {
        if let s = startedAt {
            let intervalSince = Date().timeIntervalSince(s)
            let text = String(format: "%.02f", intervalSince)
            timeLabel.text = text
        }
    }
}


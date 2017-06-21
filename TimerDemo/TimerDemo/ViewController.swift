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
    var lastTime = Date()
    var pastTime = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start() {
        stop()
        
        lastTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timer_tick), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func reset() {
        stop()
        pastTime = 0
        updateTimeLabel()
    }
    
    func updateTimeLabel() {
        let text = String(format: "%.02f", pastTime)
        timeLabel.text = text
    }

    @IBAction func startButton_touchUpInside(_ sender: Any) {
        if !timer.isValid {
            start()
        }
    }
    
    @IBAction func pauseButton_touchUpInside(_ sender: Any) {
        stop()
    }
    
    @IBAction func resetButton_touchUpInside(_ sender: Any) {
        reset()
    }
    
    func timer_tick() {
        let now = Date()
        
        let intervalSince = now.timeIntervalSince(lastTime)
        pastTime += intervalSince
        
        lastTime = now
        
        updateTimeLabel()
    }
}


//
//  ViewController.swift
//  temp-fitConstraintToBottom
//
//  Created by Ginpei on 2017-06-22.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var childView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UIView()
        v.backgroundColor = UIColor.red
        v.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(v)
        
        v.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2).isActive = true
//        v.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        v.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        v.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        v.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  assignment08-ImageGallery
//
//  Created by Ginpei on 2017-06-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.frame.origin.y = 500
        imageView.frame.size.width = 300.0
        imageView.frame.size.height = 300.0
        scrollView.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


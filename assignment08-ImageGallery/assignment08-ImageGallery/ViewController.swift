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
        imageView.image = #imageLiteral(resourceName: "img1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


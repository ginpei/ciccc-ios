//
//  DetailViewController.swift
//  assignment08-ImageGallery
//
//  Created by Ginpei on 2017-06-15.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        if image == nil {
            image = UIImage(named: "img0")
        }
        
        if let i = image {
            imageView.image = i
            imageView.widthAnchor.constraint(equalToConstant: i.size.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: i.size.height).isActive = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func back_onTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

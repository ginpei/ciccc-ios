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
    var originalWidth: CGFloat?
    var originalHeight: CGFloat?
    var scale = CGFloat(1.0)  // 1.0 == original image size, not screen size
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareImage()
        
        imageView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(onpinch)))
    }
    
    func prepareImage() {
        if image == nil {
            image = UIImage(named: "img0")
        }
        
        if let i = image {
            imageView.image = i
            
            originalWidth = i.size.width
            widthConstraint = imageView.widthAnchor.constraint(equalToConstant: originalWidth!)
            widthConstraint!.isActive = true
            
            originalHeight = i.size.height
            heightConstraint = imageView.heightAnchor.constraint(equalToConstant: originalHeight!)
            heightConstraint!.isActive = true
            
            updateImageSize()
        }
    }
    
    func updateImageSize() {
        if let ow = originalWidth, let oh = originalHeight, let wc = widthConstraint, let hc = heightConstraint {
            let width = max(ow * scale, view.frame.width)
            let height = max(oh * scale, view.frame.height)
            
            // TODO: keep aspect ratio
            
            wc.constant = width
            hc.constant = height
        }
    }
    
    func onpinch(sender: UIPinchGestureRecognizer) {
        // TODO: keep past scale
        scale = sender.scale
        updateImageSize()
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

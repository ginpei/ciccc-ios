//
//  ViewController.swift
//  assignment08-ImageGallery
//
//  Created by Ginpei on 2017-06-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imageNames = [
        "img0",
        "img1",
        "img2",
        ]
    
    var contentWidth = CGFloat(0.0)
    var currentImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = imageNames.count
        pageControl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageControl_tap)))
        
        scrollView.delegate = self
        
        let container = prepareContainer(numOfItems: imageNames.count)
        for (index, name) in imageNames.enumerated() {
            let v = prepareImage(at: index, name: name, to: container)
            
            let g = UITapGestureRecognizer(target: self, action: #selector(ontap))
            v.addGestureRecognizer(g)
        }
    }
    
    func prepareContainer(numOfItems: Int) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(v)
        
        v.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        v.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        v.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        let width = view.bounds.width * CGFloat(numOfItems)
        v.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        v.widthAnchor.constraint(equalToConstant: width).isActive = true
        v.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        return v
    }
    
    func prepareImage(at index: Int, name: String, to: UIView) -> UIImageView {
        let v = UIImageView()
        v.image = UIImage(named: name)
        v.isUserInteractionEnabled = true
        
        let width = view.bounds.width
        v.frame.origin.x = width * CGFloat(index)
        v.frame.size.width = width
        
        v.frame.origin.y = 0
        v.frame.size.height = view.bounds.height
        
        to.addSubview(v)
        
        return v
    }
    
    func ontap(sender: UITapGestureRecognizer) {
        if let v = sender.view as? UIImageView {
            currentImage = v.image
            performSegue(withIdentifier: "detail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! DetailViewController
        view.image = currentImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / view.bounds.width + 0.5)
        pageControl.currentPage = index
    }
    
    func pageControl_tap(sender: UITapGestureRecognizer) {
        let index = (pageControl.currentPage + 1) % pageControl.numberOfPages
        
        let width = view.bounds.width
        let x = width * CGFloat(index)
        scrollView.scrollRectToVisible(CGRect(x: x, y: 0, width: x+1, height: 1), animated: true)
    }
}


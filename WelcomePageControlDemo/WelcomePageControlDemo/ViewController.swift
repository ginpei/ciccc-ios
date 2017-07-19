//
//  ViewController.swift
//  WelcomePageControlDemo
//
//  Created by Ginpei on 2017-07-18.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pages = [
        Page(title: "Ichi", colorName: "red"),
        Page(title: "Ni", colorName: "green"),
        Page(title: "San", colorName: "blue"),
        ]
    var pageControlBottomConstraint: NSLayoutConstraint!
    let pageControlBottomMargin = CGFloat(-40)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePageCollectionView()
        preparePageControl()
    }
    
    func preparePageCollectionView() {
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            return layout
        }()
    }
    
    func preparePageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControlBottomConstraint = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: pageControlBottomMargin)
        pageControlBottomConstraint.isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        updatePageControlPosition(pageNumber: pageNumber)
    }
    
    func updatePageControlPosition(pageNumber: Int) {
        var constant: CGFloat
        if pageNumber == pages.count - 1 {
            constant = pageControl.frame.height
        }
        else {
            constant = pageControlBottomMargin
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControlBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
        })
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let page = pages[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as! PageCollectionViewCell
        cell.titleLabel.text = page.title
        
        var color: UIColor?
        switch page.colorName {
        case "red":
            color = UIColor.red
        case "green":
            color = UIColor.green
        case "blue":
            color = UIColor.blue
        default: break
        }
        cell.backgroundColor = color
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

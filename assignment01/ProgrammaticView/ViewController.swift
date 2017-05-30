//
//  ViewController.swift
//  ProgrammaticView
//
//  Created by Derrick Park on 2017-05-24.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let framingView: UIView = UIView(frame: CGRect.zero)
    let squareButton: UIButton = UIButton(type: .system)
    let portraitButton: UIButton = UIButton(type: .system)
    let landscapeButton: UIButton = UIButton(type: .system)
    var framingViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint.init()
    var framingViewWidthConstraint: NSLayoutConstraint = NSLayoutConstraint.init()
    
    let purpleBoxView: UIView = UIView()
    let orange1BoxView: UIView = UIView()
    let orange2BoxView: UIView = UIView()
    let redBoxView: UIView = UIView()
    let blue1BoxView: UIView = UIView()
    let blue2BoxView: UIView = UIView()
    let blue3BoxView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareButton.setTitle("Square", for: .normal)
        squareButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
        view.addSubview(squareButton)
        squareButton.translatesAutoresizingMaskIntoConstraints = false
        
        portraitButton.setTitle("Portrait", for: .normal)
        portraitButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
        view.addSubview(portraitButton)
        portraitButton.translatesAutoresizingMaskIntoConstraints = false
        
        landscapeButton.setTitle("Landscape", for: .normal)
        landscapeButton.addTarget(self, action: #selector(resizeFramingView), for: .touchUpInside)
        view.addSubview(landscapeButton)
        landscapeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonsHorizontalContraintsFormat = "|[squareButton(==portraitButton)][portraitButton(==landscapeButton)][landscapeButton]|"
        
        let buttonsHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: buttonsHorizontalContraintsFormat, options: .alignAllCenterY, metrics: nil, views: ["squareButton":squareButton, "portraitButton":portraitButton, "landscapeButton":landscapeButton])
        
        NSLayoutConstraint.activate(buttonsHorizontalContraints)
        
        let squareButtonBottomConstraint = NSLayoutConstraint.init(item: squareButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -50.0)
        squareButtonBottomConstraint.isActive = true
        
        initFramingView(framingView)
        initPurpleBoxView()
        initRedBoxView()
        initOrangeBoxView()
        initBlueBoxView()
    }
    
    func initFramingView(_ framingView: UIView) {
        
        framingView.translatesAutoresizingMaskIntoConstraints = false
        framingView.backgroundColor = UIColor.green
        view.addSubview(framingView)
        
        let framingViewCenterXContraint = NSLayoutConstraint.init(item: framingView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        framingViewCenterXContraint.isActive = true
        
        let framingViewCenterYContraint = NSLayoutConstraint.init(item: framingView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        framingViewCenterYContraint.isActive = true
        
        framingViewHeightConstraint = NSLayoutConstraint.init(item: framingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0)
        framingViewHeightConstraint.isActive = true
        
        framingViewWidthConstraint = NSLayoutConstraint.init(item: framingView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0)
        framingViewWidthConstraint.isActive = true
    }
    
    func initPurpleBoxView() {
        purpleBoxView.translatesAutoresizingMaskIntoConstraints = false
        purpleBoxView.backgroundColor = UIColor.purple
        framingView.addSubview(purpleBoxView)
        
        let x = NSLayoutConstraint.init(item: purpleBoxView, attribute: .trailing, relatedBy: .equal, toItem: framingView, attribute: .trailing, multiplier: 1.0, constant: -20.0)
        x.isActive = true
        
        let y = NSLayoutConstraint.init(item: purpleBoxView, attribute: .bottom, relatedBy: .equal, toItem: framingView, attribute: .bottom, multiplier: 1.0, constant: -20.0)
        y.isActive = true
        
        let height = NSLayoutConstraint.init(item: purpleBoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        height.isActive = true
        
        let width = NSLayoutConstraint.init(item: purpleBoxView, attribute: .width, relatedBy: .equal, toItem: framingView, attribute: .width, multiplier: 305.0 / 500.0, constant: 0.0)
        width.isActive = true
    }
    
    func initRedBoxView() {
        redBoxView.translatesAutoresizingMaskIntoConstraints = false
        redBoxView.backgroundColor = UIColor.red
        framingView.addSubview(redBoxView)
        
        redBoxView.topAnchor.constraint(equalTo: framingView.topAnchor, constant: 20).isActive = true
        redBoxView.leadingAnchor.constraint(equalTo: framingView.trailingAnchor, constant: -170).isActive = true
        redBoxView.trailingAnchor.constraint(equalTo: framingView.trailingAnchor, constant: -20).isActive = true
        NSLayoutConstraint.init(item: redBoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
    }
    
    func initOrangeBoxView() {
        orange1BoxView.translatesAutoresizingMaskIntoConstraints = false
        orange1BoxView.backgroundColor = UIColor.orange
        redBoxView.addSubview(orange1BoxView)
        
        orange1BoxView.topAnchor.constraint(equalTo: redBoxView.topAnchor, constant: 10).isActive = true
        orange1BoxView.bottomAnchor.constraint(equalTo: redBoxView.bottomAnchor, constant: -10).isActive = true
        orange1BoxView.leadingAnchor.constraint(equalTo: redBoxView.leadingAnchor, constant: 10).isActive = true
        NSLayoutConstraint.init(item: orange1BoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70.0).isActive = true
        
        orange2BoxView.translatesAutoresizingMaskIntoConstraints = false
        orange2BoxView.backgroundColor = UIColor.orange
        redBoxView.addSubview(orange2BoxView)
        
        orange2BoxView.topAnchor.constraint(equalTo: redBoxView.topAnchor, constant: 10).isActive = true
        orange2BoxView.bottomAnchor.constraint(equalTo: redBoxView.bottomAnchor, constant: -10).isActive = true
        orange2BoxView.leadingAnchor.constraint(equalTo: orange1BoxView.trailingAnchor, constant: 10).isActive = true
        NSLayoutConstraint.init(item: orange2BoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
    }
    
    func initBlueBoxView() {
        blue1BoxView.translatesAutoresizingMaskIntoConstraints = false
        blue1BoxView.backgroundColor = UIColor.blue
        framingView.addSubview(blue1BoxView)
        
        NSLayoutConstraint.init(item: blue1BoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint.init(item: blue1BoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        blue1BoxView.centerXAnchor.constraint(equalTo: framingView.centerXAnchor).isActive = true
        NSLayoutConstraint.init(item: blue1BoxView, attribute: .centerY, relatedBy: .equal, toItem: framingView, attribute: .centerY, multiplier: 0.5, constant: 0.0).isActive = true
        
        blue2BoxView.translatesAutoresizingMaskIntoConstraints = false
        blue2BoxView.backgroundColor = UIColor.blue
        framingView.addSubview(blue2BoxView)
        
        NSLayoutConstraint.init(item: blue2BoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint.init(item: blue2BoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        blue2BoxView.centerXAnchor.constraint(equalTo: framingView.centerXAnchor).isActive = true
        blue2BoxView.centerYAnchor.constraint(equalTo: framingView.centerYAnchor, constant: 0).isActive = true
        
        blue3BoxView.translatesAutoresizingMaskIntoConstraints = false
        blue3BoxView.backgroundColor = UIColor.blue
        framingView.addSubview(blue3BoxView)
        
        NSLayoutConstraint.init(item: blue3BoxView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        NSLayoutConstraint.init(item: blue3BoxView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        blue3BoxView.centerXAnchor.constraint(equalTo: framingView.centerXAnchor).isActive = true
        NSLayoutConstraint.init(item: blue3BoxView, attribute: .centerY, relatedBy: .equal, toItem: framingView, attribute: .centerY, multiplier: 1.5, constant: 0.0).isActive = true
    }

    func resizeFramingView(_ sender: UIButton) {
        var newWidth: CGFloat = 0.0
        var newHeight: CGFloat = 0.0
        if (sender == self.squareButton) {
            newWidth = 500.0
            newHeight = 500.0
        } else if (sender == self.portraitButton) {
            newWidth = 350.0
            newHeight = 550.0
        } else if (sender == self.landscapeButton) {
            newWidth = 900.0
            newHeight = 300.0
        }
        
        UIView.animate(withDuration: 2.0) {
            self.framingViewHeightConstraint.constant = newHeight
            self.framingViewWidthConstraint.constant = newWidth
            self.view.layoutIfNeeded()
        }
    }
}


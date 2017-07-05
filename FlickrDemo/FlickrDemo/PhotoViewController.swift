//
//  PhotoViewController.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        store.fetchInterestingnessPhotos() {
            (result, response) in
            
            self.showResult(result)
        }
    }
    
    func showResult(_ result:PhotoResult) {
        switch result {
        case .success(let photos):
            print(photos.count)
            for p in photos {
                print(p.url)
            }
        case let .failure(error):
            print("--- ERR \(String(describing: error))")
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

}

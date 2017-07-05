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
//            for p in photos {
//                createImage(p)
//            }
            if photos.count > 0 {
                createImage(photos[0])
            }
        case let .failure(error):
            print("--- ERR \(String(describing: error))")
        }
    }
    
    func createImage(_ photo: Photo) {
//        let imageView = UIImageView()
//        OperationQueue.main.addOperation {
//            self.view.addSubview(imageView)
//        }
        let imageView = self.imageView!
        
        store.fetchImage(for: photo) {
            (result) in
            
            OperationQueue.main.addOperation {
                switch result {
                case .success(let data):
                    imageView.image = UIImage(data: data)
                case .failure(let error):
                    print("ERROR in createImage \(error)")
                }
            }
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

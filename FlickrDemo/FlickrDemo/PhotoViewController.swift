//
//  PhotoViewController.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    let cellIdentifier = "PhotoCollectionViewCell"
    let items = [UIColor.black, UIColor.red, UIColor.blue, UIColor.orange, UIColor.darkGray, UIColor.green, UIColor.brown]
    
    var store: PhotoStore!
    var photos = [Photo]()
    var photoImages = [UIImage?]()

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
            for (i, p) in photos.enumerated() {
                self.photos.append(p)
                self.photoImages.append(nil)
                createImage(p, at: i)
            }
            OperationQueue.main.addOperation {
                self.photoCollectionView.reloadData()
            }
        case let .failure(error):
            print("--- ERR \(String(describing: error))")
        }
    }
    
    func createImage(_ photo: Photo, at index: Int) {
        store.fetchImage(for: photo) {
            (result) in
            
            OperationQueue.main.addOperation {
                switch result {
                case .success(let data):
                    self.photoImages[index] = UIImage(data: data)
                    self.photoCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                case .failure(let error):
                    print("ERROR in createImage \(error)")
                    self.photoImages[index] = nil
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = photoImages[indexPath.row]
        return cell
    }
}

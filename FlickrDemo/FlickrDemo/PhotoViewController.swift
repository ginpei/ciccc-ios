//
//  PhotoViewController.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photosLoadingIndicatorView: UIActivityIndicatorView!
    
    let cellIdentifier = "PhotoCollectionViewCell"
    let items = [UIColor.black, UIColor.red, UIColor.blue, UIColor.orange, UIColor.darkGray, UIColor.green, UIColor.brown]
    
    var store: PhotoStore!
    var photos = [Photo]()
    var photoImages = [Int: UIImage?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        photosLoadingIndicatorView.startAnimating()
        store.fetchInterestingnessPhotos() {
            (result, response) in
            
            OperationQueue.main.addOperation {
                self.showResult(result)
                self.photosLoadingIndicatorView.stopAnimating()
            }
        }
    }
    
    func showResult(_ result:PhotoResult) {
        self.photos.removeAll()
        photoImages.removeAll()
        
        switch result {
        case .success(let photos):
            self.photos.append(contentsOf: photos)
            self.photoCollectionView.reloadData()
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
                    print("ERROR in createImage \(String(describing: error))")
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
        if let i = photoImages[indexPath.row] {
            cell.imageView.image = i
        }
        else {
            cell.imageView.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = indexPath.row
        
        // do nothing if fetched or being fetched
        if photoImages.keys.contains(row) {
            return
        }
        
        // declare this item is now being fetched
        photoImages.updateValue(nil, forKey: row)
        
        // fetch
        let photo = photos[row]
        store.fetchImage(for: photo) {
            (result) in
            
            OperationQueue.main.addOperation {
                switch result {
                case let .success(data):
                    self.photoImages[row] = UIImage(data: data)
                    self.photoCollectionView.reloadItems(at: [indexPath])
                case let .failure(error):
                    print("ERROR in createImage \(String(describing: error))")
                }
                
            }
        }
    }
}

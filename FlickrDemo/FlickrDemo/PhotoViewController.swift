//
//  PhotoViewController.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photosLoadingIndicatorView: UIActivityIndicatorView!
    
    var store: PhotoStore!
    var photos = [Photo]()
    var photoImages = [Int: UIImage?]()
    
    var _loading = false
    var loading: Bool {
        get {
            return _loading
        }
        set(v) {
            _loading = v
            
            OperationQueue.main.addOperation {
                if v {
                    self.photosLoadingIndicatorView.startAnimating()
                }
                else {
                    self.photosLoadingIndicatorView.stopAnimating()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareList()
    }
    
    func prepareList() {
        loading = true
        store.fetchInterestingnessPhotos() {
            (result) in
            
            self.loading = false
            
            self.photos.removeAll()
            self.photoImages.removeAll()
            
            switch result {
            case .success(let newPhotos):
                self.photos.append(contentsOf: newPhotos)
                
                OperationQueue.main.addOperation {
                    self.photoCollectionView.reloadData()
                }
            case let .failure(error):
                print("--- ERROR in prepareList \(String(describing: error))")
            }
        }
    }
    
    func prepareImage(of photo: Photo, at indexPath: IndexPath) {
        let row = indexPath.row
        
        store.fetchThumbnail(for: photo) {
            (result) in
            
            switch result {
            case .success(let data):
                self.photoImages[row] = UIImage(data: data)
                
                OperationQueue.main.addOperation {
                    self.photoCollectionView.reloadItems(at: [indexPath])
                }
            case .failure(let error):
                print("--- ERROR in prepareImage \(String(describing: error))")
                self.photoImages[row] = nil
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.photoImages.removeAll()
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        if let i = photoImages[indexPath.row] {
            cell.imageView.image = i
        }
        else {
            cell.imageView.image = nil
        }
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = indexPath.row
        
        // do nothing if fetched or being fetched
        if photoImages.keys.contains(row) {
            return
        }
        
        // declare this item is now being fetched
        photoImages.updateValue(nil, forKey: row)
        
        // fetch and update
        let photo = photos[row]
        self.prepareImage(of: photo, at: indexPath)
    }
}

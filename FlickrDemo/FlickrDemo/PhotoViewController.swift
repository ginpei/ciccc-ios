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
            self.photos.append(contentsOf: photos)
            OperationQueue.main.addOperation {
                self.photoCollectionView.reloadData()
            }
        case let .failure(error):
            print("--- ERR \(String(describing: error))")
        }
    }
    
    func createImage(_ photo: Photo) {
        store.fetchImage(for: photo) {
            (result) in
            
            OperationQueue.main.addOperation {
                switch result {
                case .success(let data):
                    print("Loaded: \(photo.url)")
//                    TODO (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths
                    // imageView.image = UIImage(data: data)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("# photos.count=\(photos.count)")
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("# indexPath.row=\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
}

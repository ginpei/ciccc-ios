//
//  PhotoCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-06.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "PhotoCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

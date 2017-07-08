//
//  Photo.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let url: URL
    let thumbnailUrl: URL
    let photoID: String
    let dateTaken: Date
    
    init() {
        self.title = ""
        self.url = URL(string: "https://example.com")!
        self.thumbnailUrl = URL(string: "https://example.com")!
        self.photoID = ""
        self.dateTaken = Date()
    }
    
    init(title: String, url: URL, thumbnailUrl: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
}

extension Photo: Equatable {
    public static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}

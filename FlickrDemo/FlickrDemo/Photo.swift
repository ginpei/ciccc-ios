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
    let photoID: String
    let dateTaken: Date
    
    init() {
        self.title = ""
        self.url = URL(string: "https://example.com")!
        self.photoID = ""
        self.dateTaken = Date()
    }
    
    init(title: String, url: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.url = url
        self.photoID = photoID
        self.dateTaken = dateTaken
    }
}

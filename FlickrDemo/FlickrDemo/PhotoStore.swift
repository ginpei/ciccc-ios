//
//  PhotoStore.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

enum PhotoResult {
    case success([Photo])
    case failure(Error?)
}

enum PhotoError: Error {
    case unhandledError
}

enum ImageResult {
    case success(Data)
    case failure(Error?)
}

enum ImageError: Error {
    case imageCreationError
}

class PhotoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchThumbnail(for photo: Photo, completionHandler: @escaping (ImageResult) -> Void) {
        let request = URLRequest(url: photo.thumbnailUrl)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            var result: ImageResult
            if error != nil {
                result = .failure(error)
            }
            else if let d = data
            {
                result = .success(d)
            }
            else {
                result = .failure(ImageError.imageCreationError)
            }
            
            completionHandler(result)
        }
        task.resume()
    }
    
    func fetchInterestingnessPhotos(completionHandler: @escaping (PhotoResult) -> Void) {
        let url = FlickrAPI.interestingnessURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            var result: PhotoResult
            if error != nil {
                result = .failure(error)
            }
            if let d = data {
                result = FlickrAPI.photos(fromJSON: d)
            }
            else {
                result = .failure(PhotoError.unhandledError)
            }
            completionHandler(result)
        }
        
        task.resume()
    }
}

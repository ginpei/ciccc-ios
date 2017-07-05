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
    
//    private func processPhotosRequest(data: Data?, error: Error) -> PhotoResult {
//        guard let jsonData = data else {
//            return .failure(error)
//        }
//        return FlickrAPI.photos(fromJSON: data)
//    }
    
//    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
//        if error != nil {
//            return .failure(error)
//        }
//        else if let imageData = data,
//            let image = UIImage(data: imageData)
//        {
//            return .success(image)
//        }
//        else {
//            return .failure(ImageError.imageCreationError)
//        }
//    }
    
    func fetchImage(for photo: Photo, completionHandler: @escaping (ImageResult) -> Void) {
        let request = URLRequest(url: photo.url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            var result: ImageResult = .failure(ImageError.imageCreationError)
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
    
    func fetchInterestingnessPhotos(completionHandler: @escaping (PhotoResult, URLResponse?) -> Void) {
        let url = FlickrAPI.interestingnessURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            if let d = data {
                let result = FlickrAPI.photos(fromJSON: d)
                completionHandler(result, response)
            }
            else {
                completionHandler(PhotoResult.failure(error), response)
            }
        }
        
        task.resume()
    }
}

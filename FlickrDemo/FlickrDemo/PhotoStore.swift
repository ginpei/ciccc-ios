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

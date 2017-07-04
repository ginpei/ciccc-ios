//
//  PhotoStore.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

class PhotoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingnessPhotos() {
        let url = FlickrAPI.interestingnessURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            if let e = error {
                print("ERROR! \(e)")
            }
            else if let d = data {
                let jsonString = String(data: d, encoding: .utf8)
                print("JSON: \(jsonString ?? "???")")
            }
        }
        
        task.resume()
    }
}

//
//  FlickrAPI.swift
//  FlickrDemo
//
//  Created by Ginpei on 2017-07-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

enum Method: String {
    case interestingnessPhotos = "flickr.interestingness.getList"
}

enum FlickrError: Error {
    case invalidJSONData
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = ProcessInfo.processInfo.environment["FLICKR_API_KEY"]!  // from "Edit Scheme"->"Arguments"->"Environment Variables"
    
    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyy-MM-dd HH:mm:ss"
        return f
    }()
    
    static func interestingnessURL() -> URL {
        return flickrURL(method: .interestingnessPhotos, parameters: ["extras":"url_h,url_b,url_m,date_taken"])
    }
    
    private static func flickrURL(method: Method, parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "api_key": apiKey,
            "nojsoncallback": "1",
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.url!
    }
    
    static func photos(fromJSON data: Data) -> PhotoResult {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDictionary = json as? [AnyHashable:Any],
                let photosJson = jsonDictionary["photos"] as? [String:Any],
                let photoJsonArray = photosJson["photo"] as? [[String:Any]] else {
                    NSLog("Failed to parse: %@", String(data: data, encoding: .utf8) ?? "(Couldn't to convert to String)")
                    return .failure(FlickrError.invalidJSONData)
            }
            
            var result = [Photo]()
            for photoJson in photoJsonArray {
                if let photo = photo(fromJSON: photoJson) {
                    result.append(photo)
                }
            }
            
            if !photoJsonArray.isEmpty && result.isEmpty {
                NSLog("Shouldn't be empty")
                return .failure(FlickrError.invalidJSONData)
            }
            
            return .success(result)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func photo(fromJSON json: [String: Any]) -> Photo? {
        if let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let url = photoUrlOf(json: json),
            let dateTakenString = json["datetaken"] as? String,
            let dateTaken = dateFormatter.date(from: dateTakenString)
        {
            return Photo(title: title, url: url, photoID: photoID, dateTaken: dateTaken)
        }
        else {
            NSLog("Failed to create a Photo object: %@", json)
            return nil
        }
    }
    
    static func photoUrlOf(json: [String: Any]) -> URL? {
        var urlString: String? = nil
        
        if let u = json["url_h"] as? String {
            urlString = u
        }
        else if let u = json["url_b"] as? String {
            urlString = u
        }
        else if let u = json["url_m"] as? String {
            urlString = u
        }
        
        if urlString != nil {
            return URL(string: urlString!)
        }
        else {
            return nil
        }
    }
}

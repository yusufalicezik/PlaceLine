//
//  ImageServiceManager.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import Alamofire
import MapKit
class ImageServiceManager {
    static let shared = ImageServiceManager()
    private init(){}
    internal func getFlickrImageUrl(_ annotation:MKPointAnnotation, completion:@escaping ((_ list:[String])->())){
        Alamofire.request(flickUrl(key: "2e813352b4225f7db2d993b7942e5f3b", annotation: annotation, pagesNumber: 40)).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
            let photosDict = json["photos"] as! Dictionary<String,AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String,AnyObject>]
            var imageUrlArray = [String]()
            for photo in photosDictArray {
                let url = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_m_d.jpg"
                imageUrlArray.append(url)
            }
            completion(imageUrlArray)
        }
    }
}

//
//  Constants.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import MapKit
let apiKey = "2e813352b4225f7db2d993b7942e5f3b"
func flickUrl(key: String, annotation:MKPointAnnotation, pagesNumber:Int)->String{
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(pagesNumber)&format=json&nojsoncallback=1"
}

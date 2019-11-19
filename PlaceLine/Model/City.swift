//
//  City.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
struct City:Codable {
    let response:Response
}

struct Response: Codable {
    let venues: [Venue]
    let geocode: Geocode?
}
struct Geocode: Codable {
    let what, geocodeWhere: String
    
    enum CodingKeys: String, CodingKey {
        case what
        case geocodeWhere = "where"
    }
}
struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories:[Category_]
    
    enum CodingKeys: String, CodingKey {
        case id, name, location,categories
    }
}
struct Category_:Codable{
    let id:String?
    let name:String?
    let shortName:String?
    let icon:Icon?
}
struct Icon:Codable{
    let prefix:String?
    let suffix:String?
}
struct Location: Codable {
    let address: String?
    let lat, lng: Double
}

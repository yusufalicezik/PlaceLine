//
//  VenueViewModel.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 20.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import UIKit
import MapKit
struct VenueListViewModel{
    private var venues:[Venue]
}
extension VenueListViewModel{
    var numberOfSections:Int{
        return 1
    }
    var numberOfRowsSection:Int{
        return venues.count
    }
    func getVenueAt(index:Int)->VenueViewModel{
        return VenueViewModel(venues[index])
    }
    init(_ venues:[Venue]) {
        self.venues = venues
    }
    mutating func clearData(){
        self.venues.removeAll()
    }
}

struct VenueViewModel {
    private let venue:Venue
}
extension VenueViewModel{
    init(_ venue:Venue) {
        self.venue = venue
    }
}
extension VenueViewModel{
    var venueName:String{
        return self.venue.name
    }
    var venueShortAddres:String{
        if let address = self.venue.location.address{
            return address
        }else{
            return ""
        }
    }
    var venueLocatin:Location{
        return self.venue.location
    }
    var venueIconUrl:String{
        return (self.venue.categories[0].icon?.prefix)! + "64"+(self.venue.categories[0].icon?.suffix)!
    }
    var venueId:String{
        return venue.id
    }
    var venueAnnotation:MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.venueLocatin.lat, longitude: self.venueLocatin.lng)
        return annotation
    }
    var venueRegion:MKCoordinateRegion{
        let diameter = 0.75 * 2000
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.venueLocatin.lat, longitude: self.venueLocatin.lng), latitudinalMeters: diameter, longitudinalMeters: diameter)
        return region
    }
    var venueID:String{
        return self.venue.id
    }
}

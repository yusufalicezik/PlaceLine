//
//  PlanViewModel.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 21.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import MapKit
struct PlanListViewModel{
    private var planList:[PlanData]
}
extension PlanListViewModel{
    init(_ planList:[PlanData] = []) {
        self.planList = planList
    }
}
extension PlanListViewModel{
    var numberOfRowsInSection:Int{
        return self.planList.count
    }
    mutating func removeAllList(){
        self.planList.removeAll()
    }
    mutating func addItemToList(_ planData:PlanData){
        self.planList.append(planData)
    }
    func getItemAt(index:Int)->PlanViewModel{
        return PlanViewModel(self.planList[index])
    }
    func isLast(_ planViewModel:PlanViewModel)->Bool{
        return planViewModel.plan.plan?.venueId == self.planList.last?.plan?.venueId
    }
}
struct PlanViewModel{
    var plan:PlanData
}
extension PlanViewModel{
    init(_ plan:PlanData) {
        self.plan = plan
    }
}
extension PlanViewModel{
    var isDone:Bool{
        return self.plan.plan?.isDone ?? false
    }
    var venueDescription:String{
        return self.plan.plan?.venue_description ?? ""
    }
    var venueName:String{
        return self.plan.plan?.venue_name ?? ""
    }
    var venueLocation:CLLocationCoordinate2D{
        return self.plan.plan?.venue_location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    var venueImage:String{
        return self.plan.plan?.venue_image ?? ""
    }
    var venueShortAddress:String{
        return self.plan.plan?.venue_short_address ?? ""
    }
    var venueTimeString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE" //31.12.1997 Perşembe
        dateFormatter.locale = Locale(identifier: "tur")
        return dateFormatter.string(from: self.plan.plan?.venue_time ?? Date())
    }
    
    var isPlan:Bool{
        return self.plan.isPlan
    }
    func getVenueDistance(_ currentLocation:CLLocationCoordinate2D)->String{
        let location1 = CLLocation(latitude: self.venueLocation.latitude, longitude: self.venueLocation.longitude)
        let location2 = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        let distanceInMeters = location1.distance(from: location2)
        let distanceKM = Double(distanceInMeters/1000).rounded(toPlaces: 2)
        print(distanceKM)
        return "\(distanceKM) km"
    }
}

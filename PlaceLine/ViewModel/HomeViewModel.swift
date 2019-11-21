//
//  PlanViewModel.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 21.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation
struct HomeViewModel{
    var planListViewModel = PlanListViewModel()
    var context:HomeViewController?
    init() {}
    mutating func fetchDataFromLocal(_ completion:((Bool)->())){
        self.planListViewModel.removeAllList()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                var mPlan = PlanModel()
                mPlan.isDone = false
                mPlan.venue_description = data.value(forKey: "venue_description") as? String
                mPlan.venue_name = data.value(forKey: "venue_name") as? String
                mPlan.venue_image = data.value(forKey: "venue_image") as? String
                mPlan.venue_short_address = data.value(forKey: "venue_short_address") as? String
                mPlan.venue_time = data.value(forKey: "venue_time") as? Date
                mPlan.venueId = data.value(forKey: "id") as? String
                mPlan.venue_location = CLLocationCoordinate2D(latitude: (data.value(forKey: "lat") as? Double)!, longitude: (data.value(forKey: "long") as? Double)!)
                self.planListViewModel.addItemToList(PlanData(plan:mPlan, isPlan: true))
                //if data != result.last as! NSManagedObject{
                    self.planListViewModel.addItemToList(PlanData(plan:mPlan, isPlan: false))
                //}
                print(data.value(forKey: "venue_name") as! String)
            }
            completion(true)
        } catch {
            print("Failed")
        }
    }
}


struct PlanData{
    var plan:PlanModel?
    var isPlan = false
}
struct PlanModel{
    var isDone:Bool?
    var venue_description:String?
    var venue_name:String?
    var venue_image:String?
    var venue_time:Date?
    var venue_short_address:String?
    var venue_location:CLLocationCoordinate2D?
    var venueId:String?
}

//
//  PlanViewModel.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 21.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
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
}
struct PlanViewModel{
    private var plan:PlanData
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
    var venueImage:String{
        return self.plan.plan?.venue_image ?? ""
    }
    var venueShortAddress:String{
        return self.plan.plan?.venue_short_address ?? ""
    }
    var venueTimeString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self.plan.plan?.venue_time ?? Date())
    }
    var isPlan:Bool{
        return self.plan.isPlan
    }
}

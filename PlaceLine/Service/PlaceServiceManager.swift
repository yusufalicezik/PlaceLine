//
//  PlaceServiceManager.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import Alamofire
class PlaceServiceManager {
    static let shared = PlaceServiceManager()
    var currentRequest:DataRequest?
    private init(){}
    func getVenuesForQuickSearch(byVenueName venueName:String, completion : @escaping ((_ data:City)->())){
        let params = [
            "client_id":"KBQZSAA5CIFBVE3N1HVP31ACPCOL1KRJR10RXROWDD04EXTP",
            "client_secret":"Y0EH1X5LY0YSTHQ13UVCYDLLEH0KVRET1CLA1CIB040Q0EQ5",
            "v":"20191211",
            "intent":"global",
            "query":"\(venueName)"
        ]
        let url = URL(string: "https://api.foursquare.com/v2/venues/search?")
        currentRequest = Alamofire.request(url!, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isFailure{
                //error
            }else{
                do {
                    let json = try JSONDecoder().decode(City.self, from: response.data!)
                    completion(json)
                }catch(let err){
                    print(err)
                }
            }
        }
    }
}

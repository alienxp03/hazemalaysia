//
//  HazeApiController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftDate

class HazeApiController : BaseApi {
    func createOrUpdateAreas(json: JSON) {
        var areas = [NSDictionary]()

        for (_, result):(String, JSON) in json["result"] {
            if Settings.areas.count == 0 || Settings.areas.count != json["result"].count {
                let area = [
                    "name" : result["lokasi"].stringValue,
                    "state" : result["negeri"].stringValue
                ]
                areas.append(area)
            } else {
                break
            }
        }
        
        Settings.areas = areas
    }
    
    func getLatestReading(completion: [NSDictionary] -> ()) {
        var readings = [NSDictionary]()

        Alamofire.request(.GET, baseURL)
            .responseJSON(completionHandler: {
                response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    
                    for (_, result):(String, JSON) in json["result"] {
                        self.createOrUpdateAreas(json["result"])
                        
                        let reading = [
                            "area" : result["lokasi"].stringValue,
                            "state" : result["negeri"].stringValue,
                            "reading" : result["terkini"].stringValue,
                            "latitude" : result["location"]["coordinates"]["latitude"].doubleValue,
                            "longitude" : result["location"]["coordinates"]["longitude"].doubleValue
                        ]
                        readings.append(reading)
                    }
                    
                    
                    guard let date = json["last_updated"].stringValue.toDate(DateFormat.Custom("yyyy-MM-dd HH:mm:ss")) else { return }

                    if Settings.lastUpdated == nil || date < NSDate() {
                        Settings.lastUpdated = date
                    }

                    completion(readings.sort({ ($0["area"] as! String) < ($1["area"] as! String) }))
                } else {
                    print("Failed",response)
                }
            })
    }
}

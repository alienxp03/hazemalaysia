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
    func getLatestReading(completion: [NSDictionary] -> ()) {
        var readings = [NSDictionary]()

        Alamofire.request(.GET, fromURL("/statistics/latest"))
            .responseJSON(completionHandler: {
                response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    
                    for (_, result):(String, JSON) in json {
                        let area = [
                            "area" : result["area"].stringValue,
                            "state" : result["state"].stringValue,
                            "time" : result["time"].stringValue,
                            "reading" : result["reading"].stringValue
                        ]
                        readings.append(area)
                        
                        guard let date = NSDate.date(fromString: result["time"].stringValue, format: DateFormat.Custom("dd-MM-yyyy HH:mm")) else { return }

                        if Settings.lastUpdated == nil || date < NSDate() {
                            Settings.lastUpdated = date
                        }
                    }
                    print(readings.count)
                    completion(readings)
                } else {
                    print("Failed",response)
                }
            })
    }
    
    func getLatestReadingForArea(var name: String, completion: [NSDictionary] -> ()) {
        var readings = [NSDictionary]()
        
        name = name.stringByReplacingOccurrencesOfString(" ", withString: "-").lowercaseString
        
        Alamofire.request(.GET, fromURL("/statistics/\(name)"))
            .responseJSON(completionHandler: {
                response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    
                    for (_, result):(String, JSON) in json {
                        let area = [
                            "area" : result["area"].stringValue,
                            "state" : result["state"].stringValue,
                            "time" : result["time"].stringValue,
                            "reading" : result["reading"].stringValue
                        ]
                        readings.append(area)
                        
                        let date = NSDate.date(fromString: result["time"].stringValue, format: DateFormat.ISO8601)
                        if Settings.lastUpdated == nil || date < NSDate() {
                            Settings.lastUpdated = date
                        }
                    }
                    completion(readings)
                }
            })
    }
    
    func getAreas(completion: [NSDictionary] -> ()) {
        var areas = [NSDictionary]()

        Alamofire.request(.GET, fromURL("/areas"))
        .responseJSON(completionHandler: {
            response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                
                for (_, result):(String, JSON) in json {
                    let area = [
                        "name" : result["name"].stringValue,
                        "state" : result["state"].stringValue
                    ]
                    areas.append(area)
                }
                completion(areas)
            }
        })
    }
}

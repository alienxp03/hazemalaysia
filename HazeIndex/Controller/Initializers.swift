//
//  Initializers.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import SwiftDate

class Initializers: NSObject {
    static let apiController = HazeApiController()
    
    class func firstTimeSetup() {
        if Settings.areas.count == 0 {
            apiController.getAreas({
                result in
                Settings.areas = result
            })
        }

        updateLatestReading()
    }
    
    class func updateLatestReading() {
        var shouldUpdate = false

        if Settings.lastUpdated == nil || ((NSDate() - Settings.lastUpdated) / 60) > 60 {
            shouldUpdate = true
            print("reset", Settings.readings.count)
        } else {
            return
        }

        if shouldUpdate || Settings.readings.count < NSDate().hour {
            print("will update")
            apiController.getLatestReading {
                result in
                print("Post")
                Settings.readings = result
                NSNotificationCenter.defaultCenter().postNotificationName("updateReading", object: nil)
            }
        } else {
            print("Should not update")
        }
    }
    
    class func updateReading(name: String) {
        var shouldUpdate = false
        
        if Settings.lastUpdated == nil || ((NSDate() - Settings.lastUpdated) / 60) > 60 {
            shouldUpdate = true
            Settings.readings = []
        }
        
        if shouldUpdate || Settings.readings.count < NSDate().hour {
            apiController.getLatestReadingForArea(name, completion: {
                result in
                Settings.readings = result
                NSNotificationCenter.defaultCenter().postNotificationName("updateReading", object: nil)
            })
        }
    }
}

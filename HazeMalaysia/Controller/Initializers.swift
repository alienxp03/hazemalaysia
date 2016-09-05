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
    
    class func setup() {
        apiController.getLatestReading {
            result in
            Settings.readings = result
        }
    }
    
    class func updateLatestReading() {
//        var shouldUpdate = false
//        
//        if Settings.lastUpdated == nil || ((NSDate.today() - Settings.lastUpdated) / 60) > 60 {
//            if Settings.lastUpdated != nil {
////                JDStatusBarNotification.showWithStatus("Fetching latest status", dismissAfter: 2)
//            }
//            shouldUpdate = true
//        } else {
////            JDStatusBarNotification.showWithStatus("All data in sync", dismissAfter: 2)
//        }
        
        if Settings.readings.count < NSDate().hour {
            apiController.getLatestReading {
                result in
                Settings.readings = result
                NSNotificationCenter.defaultCenter().postNotificationName("updateReading", object: nil)
            }
        }
    }
}

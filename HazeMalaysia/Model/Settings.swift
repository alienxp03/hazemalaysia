//
//  Settings.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

//typealias Settings : Defaults
class Settings {
    static var firstLaunch: Bool? {
        set {
            Defaults[.firstLaunch] = newValue
        }
        get {
            return Defaults[.firstLaunch]
        }
    }
    
    static var lastUpdated: NSDate! {
        set {
            Defaults[.lastUpdated] = newValue
        }
        get {
            return Defaults[.lastUpdated]
        }
    }
    
    static var currentLocation: String {
        set {
            Defaults[.currentTown] = newValue
        }
        get {
            return Defaults[.currentTown]
        }
    }
    
    static var areas: NSArray {
        set {
            Defaults[.areas] = newValue
        }
        get {
            return Defaults[.areas]
        }
    }
    
    static var readings: NSArray {
        set {
            Defaults[.readings] = newValue
        }
        get {
            return Defaults[.readings]
        }
    }
    
    static var currentLocationReading: String {
        get {
            var locationReading = "60"
            let locations = readings.filter{ el in (el["area"] as! String).containsString(currentLocation) }
            
            if readings.count > 0 {
                locationReading = (locations.sort({ ($0["reading"] as! String) > ($1["reading"] as! String) })
                    .first as! NSDictionary)["reading"] as! String
            }
            
            return locationReading
        }
    }
    
    static var currentLocationStatus : Status {
        return HazeStatus.status(Int(currentLocationReading)!)
    }
}

extension DefaultsKeys {
    static let firstLaunch = DefaultsKey<Bool?>("firstLaunch")
    static let currentTown = DefaultsKey<String>("currentTown")
    static let areas = DefaultsKey<NSArray>("areas")
    static let readings = DefaultsKey<NSArray>("readings")
    static let lastUpdated = DefaultsKey<NSDate?>("lastUpdated")
}

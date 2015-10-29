//
//  Settings.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import CoreLocation

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
    
    static var userLocation: [String: AnyObject] {
        set {
            Defaults[.userLocation] = newValue
        }
        get {
            return Defaults[.userLocation]
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
            let userCoordinate = CLLocation(latitude: userLocation["latitude"] as! Double, longitude: userLocation["longitude"] as! Double)
            
            var locationReading = "60"
            var previousDistance = Double.infinity
            for reading in readings {
                let readingLocation = CLLocation(latitude: reading["latitude"] as! Double, longitude: reading["longitude"] as! Double)
                
                let distance = userCoordinate.distanceFromLocation(readingLocation)
                if previousDistance > distance {
                    previousDistance = distance
                    locationReading = reading["reading"] as! String
                }
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
    static let userLocation = DefaultsKey<[String: AnyObject]>("userLocation")
    static let areas = DefaultsKey<NSArray>("areas")
    static let readings = DefaultsKey<NSArray>("readings")
    static let lastUpdated = DefaultsKey<NSDate?>("lastUpdated")
}

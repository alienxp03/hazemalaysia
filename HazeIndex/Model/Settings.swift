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
    static var lastUpdated: NSDate! {
        set {
            Defaults[.lastUpdated] = newValue
        }
        get {
            return Defaults[.lastUpdated]
        }
    }
    
    static var currentTown: String {
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
            for reading in readings {
                if reading["area"] as! String == currentTown {
                    locationReading = reading["reading"] as! String
                    break
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
    static let currentTown = DefaultsKey<String>("currentTown")
    static let areas = DefaultsKey<NSArray>("areas")
    static let readings = DefaultsKey<NSArray>("readings")
    static let lastUpdated = DefaultsKey<NSDate?>("lastUpdated")
}

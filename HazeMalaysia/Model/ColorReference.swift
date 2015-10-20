//
//  ColorReference.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 16/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

struct HazeStatus {
    static func status(index: Int) -> Status {
        if index >= 0 && index <= 50 {
            return .Good
        } else if index >= 51 && index <= 100 {
            return .Moderate
        } else if index >= 101 && index <= 200 {
            return .Unhealthy
        } else if index >= 201 && index <= 300 {
            return .VeryUnhealthy
        } else if index > 300 {
            return .Hazardous
        }
        return .Good
    }
}

enum Status : String {
    case Good           = "Good"
    case Moderate       = "Moderate"
    case Unhealthy      = "Unhealthy"
    case VeryUnhealthy  = "Very Unhealthy"
    case Hazardous      = "Hazardous"
    
    var color : UIColor {
        switch self {
        case Good:
            return UIColor(red:0.25, green:0.73, blue:0.85, alpha:1)
        case Moderate:
            return UIColor(red:0.63, green:0.81, blue:0.16, alpha:1)
        case Unhealthy:
            return UIColor(red:0.99, green:0.85, blue:0.01, alpha:1)
        case VeryUnhealthy:
            return .orangeColor()
        case Hazardous:
            return .redColor()
        }
    }
}
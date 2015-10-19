//
//  BaseApi.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

class BaseApi {
    let baseURL = "http://hazeapp.herokuapp.com/api"

    func fromURL(string: String) -> String {
        return "\(baseURL)\(string)"
    }
}

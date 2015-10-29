//
//  IntroductionViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 19/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import CoreLocation

class IntroductionViewController: UIViewController {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }

    @IBAction func allowAccess(sender: AnyObject) {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension IntroductionViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        location.coordinate.latitude
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            placemarks, errors in
            guard let town = placemarks?.last?.locality else { return }
            
            let userLocation: [String: AnyObject] = [
                "town": town,
                "latitude": location.coordinate.latitude,
                "longitude": location.coordinate.longitude
            ]
            Settings.firstLaunch = false
            Settings.userLocation = userLocation

            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
        })
    }
}
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
        locationManager.requestWhenInUseAuthorization()
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
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            placemarks, errors in
            guard let location = placemarks?.last?.locality else { return }

            Settings.firstLaunch = false
            Settings.currentLocation = location
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
        })
    }
}
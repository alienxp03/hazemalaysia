//
//  CurrentLocationViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 16/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import SwiftDate
import CoreLocation

class CurrentLocationViewController: UIViewController {
    @IBOutlet weak var readingCircle: UILabel!
    @IBOutlet weak var reading: UILabel!
//    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var date: UILabel!
    
    let notification = CWStatusBarNotification()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CurrentLocationViewController.updateView), name: "updateReading", object: nil)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        Initializers.updateLatestReading()
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        navigationItem.title = Settings.userLocation["town"] as? String
        date.text = NSDate().toString(DateFormat.Custom("dd MMM"))
        reading.text = Settings.currentLocationReading
        
        navigationController?.navigationBar.barTintColor = HazeStatus.status(NSString(string: reading.text!).integerValue).color
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 24)!,
            NSForegroundColorAttributeName : UIColor.darkGrayColor()
        ]
        blurView.backgroundColor = HazeStatus.status(NSString(string: reading.text!).integerValue).color
        
        // Draw circle on reading
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: reading.frame.width, height: reading.frame.height)).CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor.whiteColor().CGColor
        circleLayer.lineWidth = 2
        reading.layer.addSublayer(circleLayer)
    }
}

// MARK: - CLLocationManagerDelegate
extension CurrentLocationViewController : CLLocationManagerDelegate {
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
            guard let town = placemarks?.last?.locality else { return }
            
            let userLocation: [String: AnyObject] = [
                "town": town,
                "latitude": location.coordinate.latitude,
                "longitude": location.coordinate.longitude
            ]
            
            if Settings.userLocation["town"] as! String != town {
                Settings.userLocation = userLocation
                self.updateView()
                
                NSNotificationCenter.defaultCenter().postNotificationName("updateReading", object: nil)
            }
        })
    }
}

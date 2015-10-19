//
//  ViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyUserDefaults
import SwiftyJSON
import SwiftDate

class PlacesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var readings = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge.None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateReading", name: "updateReading", object: nil)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        requestUserLocationPermission()
        
        tableView.registerNib(UINib(nibName: "StatisticCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        updateReading()
    }

    // MARK: - Functions
    func updateReading() {
        print("updating", Settings.readings.count)
        readings = Settings.readings
        tableView.reloadData()
    }
    
    // MARK: - LocationManager
    func requestUserLocationPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension PlacesViewController : CLLocationManagerDelegate {
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
            
            if Settings.currentTown != town {
                Settings.currentTown = town
            }
        })
    }
}

// MARK: - UITableViewDelegate
extension PlacesViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StatisticTableViewCell
        cell.area.text = readings[indexPath.row]["area"] as? String
        cell.reading.text = readings[indexPath.row]["reading"] as? String
        
//        let dateTime = NSDate.date(fromString: readings[indexPath.row]["time"] as! String, format: DateFormat.Custom("dd-MM-yyyy HH:mm"))
//        cell.time.text = dateTime?.toShortTimeString()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readings.count
    }
}

extension PlacesViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

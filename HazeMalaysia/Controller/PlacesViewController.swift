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
    
    var readings = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlacesViewController.updateReading), name: "updateReading", object: nil)
        
        tableView.registerNib(UINib(nibName: "StatisticCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        updateReading()
    }

    // MARK: - Functions
    func updateReading() {
        readings = Settings.readings
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension PlacesViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StatisticTableViewCell
        cell.area.text = readings[indexPath.row]["area"] as? String
        cell.reading.text = readings[indexPath.row]["reading"] as? String

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

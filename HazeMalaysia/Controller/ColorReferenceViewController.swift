//
//  SettingsViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 19/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

class ColorReferenceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var legends: [[String: Any]] = [
        [
            "range": "0 - 50",
            "status": Status.Good
        ],
        [
            "range": "51 - 100",
            "status": Status.Moderate
        ],
        [
            "range": "101 - 200",
            "status": Status.Unhealthy
        ],
        [
            "range": "201 - 300",
            "status": Status.VeryUnhealthy
        ],
        [
            "range": "Above 300",
            "status": Status.Hazardous
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "LegendCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension ColorReferenceViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LegendTableViewCell
        let status = legends[indexPath.row]["status"] as! Status
        cell.status.text = status.rawValue
        cell.color.backgroundColor = status.color
        cell.details.text = status.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legends.count
    }
}

extension ColorReferenceViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
}

//
//  CurrentLocationViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 16/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import SwiftDate

class CurrentLocationViewController: UIViewController {
    @IBOutlet weak var readingCircle: UILabel!
    @IBOutlet weak var reading: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var date: UILabel!
    
    let notification = CWStatusBarNotification()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateView", name: "updateReading", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        Initializers.updateLatestReading()
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        area.text = Settings.currentLocation
        date.text = NSDate().toString(format: DateFormat.Custom("dd MMM"))
        reading.text = Settings.currentLocationReading
        
        blurView.backgroundColor = HazeStatus.status(NSString(string: reading.text!).integerValue).color
        
        // Draw circle on reading
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: reading.frame.width, height: reading.frame.height)).CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
//                circleLayer.fillColor = HazeStatus.status(NSString(string: reading.text!).integerValue).color.CGColor
                circleLayer.strokeColor = UIColor.whiteColor().CGColor
        circleLayer.lineWidth = 2
        reading.layer.addSublayer(circleLayer)
    }
}

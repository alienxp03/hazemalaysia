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
    @IBOutlet weak var reading: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var date: UILabel!
    
    let notification = CWStatusBarNotification()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.notificationLabelBackgroundColor = .whiteColor()
        notification.notificationLabelTextColor = .blackColor()
        UIView.animateWithDuration(2.0, animations: {
            
            }, completion: {
                finished in
            self.notification.displayNotificationWithMessage("Updating data", forDuration: 2.0)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        area.text = Settings.currentTown
        date.text = NSDate().toString(format: DateFormat.Custom("dd MMM"))
        reading.text = Settings.currentLocationReading
        
        // Draw circle on reading
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: reading.frame.width, height: reading.frame.height)).CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor.whiteColor().CGColor
        circleLayer.lineWidth = 2
        reading.layer.addSublayer(circleLayer)
    }
}

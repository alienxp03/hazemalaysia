//
//  StatisticTableViewCell.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 15/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var reading: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        reading.textColor = HazeStatus.status(NSString(string: reading.text!).integerValue).color
        
        // Draw circle on reading
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: reading.frame.width, height: reading.frame.height)).CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        //        circleLayer.fillColor = HazeStatus.status(Int(reading.text!)!).color.CGColor
        circleLayer.strokeColor = HazeStatus.status(Int(reading.text!)!).color.CGColor
        circleLayer.lineWidth = 2
        reading.layer.addSublayer(circleLayer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

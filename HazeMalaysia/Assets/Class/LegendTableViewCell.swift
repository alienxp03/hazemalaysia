//
//  LegendTableViewCell.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 19/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

class LegendTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var api: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

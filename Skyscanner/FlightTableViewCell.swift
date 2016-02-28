//
//  FlightTableViewCell.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/28/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var dateOutLabel: NSLayoutConstraint!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var directLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

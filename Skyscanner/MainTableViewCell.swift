//
//  MainTableViewCell.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/28/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var firstImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

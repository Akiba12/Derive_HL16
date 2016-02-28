//
//  UnderlineButton.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/27/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit

class UnderlineButton: UIButton {
    
    var line:CALayer?
    
    override var selected: Bool {
        didSet {
            if let line = line {
                line.hidden = !selected
            } else {
                line = CALayer()
                line?.frame = CGRectMake(0, self.frame.size.height-3, self.frame.size.width, 3)
//                line?.frame = CGRectMake(20, self.frame.size.height-10, self.frame.size.width-40, 2)
                line?.backgroundColor = UIColor.whiteColor().CGColor
                layer.addSublayer(line!)
                line?.hidden = !selected
            }
            self.alpha = selected ? 1 : 0.8
        }
    }

}

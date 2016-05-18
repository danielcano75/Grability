//
//  AppTableCell.swift
//  Test
//
//  Created by Daniel Cano on 17/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation

class AppTableCell: UITableViewCell {
    
    @IBOutlet weak var icnApp: UIImageView!
    @IBOutlet weak var lblApp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

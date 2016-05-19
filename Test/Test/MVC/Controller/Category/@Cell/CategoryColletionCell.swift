//
//  CategoryViewCell.swift
//  Test
//
//  Created by Daniel Cano on 16/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation

class CategoryColletionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCatecory: UILabel!
    @IBOutlet weak var vLine: UIView!
    
    override init (frame: CGRect) {
        
        self.lblCatecory = UILabel(frame: CGRect(x: 30, y: 0, width: frame.size.width, height: frame.size.height))
        self.vLine = UILabel(frame: CGRect(x: 0, y: 59, width: frame.size.width, height: 1))
        
        super.init(frame: frame)
        
        contentView.addSubview(self.lblCatecory)
        contentView.addSubview(self.vLine)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

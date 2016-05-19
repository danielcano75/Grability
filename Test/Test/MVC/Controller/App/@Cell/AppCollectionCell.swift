//
//  AppCollectionCell.swift
//  Test
//
//  Created by Daniel Cano on 17/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation

class AppCollectionCell: UICollectionViewCell {

    @IBOutlet weak var icnApp: UIImageView!
    @IBOutlet weak var lblApp: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var vApp: UIView!
    
    override init (frame: CGRect) {
        
        self.icnApp = UIImageView (frame: CGRect(x: 8, y: 25, width: frame.size.width, height: frame.size.height))
        self.lblApp = UILabel(frame: CGRect(x: 74, y: 8, width: frame.size.width, height: frame.size.height))
        self.lblCategory = UILabel(frame: CGRect(x: 74, y: 68, width: frame.size.width, height: 1))
        self.vApp = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame)
        
        contentView.addSubview(self.icnApp)
        contentView.addSubview(self.lblApp)
        contentView.addSubview(self.lblCategory)
        contentView.addSubview(self.vApp)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

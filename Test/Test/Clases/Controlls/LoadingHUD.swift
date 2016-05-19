//
//  LoadingHUD.swift
//  Test
//
//  Created by Daniel Cano on 15/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import APESuperHUD

class LoadingHUD: NSObject {
    
    override init() {
        super.init()
    }
    
    internal func showLoading(view: UIView) -> Void {
        APESuperHUD.showOrUpdateHUD(icon: .CheckMark, message: "Synced", presentingView: view, completion: { _ in
        })
    }
    
    internal func removeLoading(view: UIView) -> Void {
        APESuperHUD.removeHUD(animated: true, presentingView: view, completion: { _ in
        })
    }
    
}

//
//  DetailViewController.swift
//  Test
//
//  Created by Daniel Cano on 12/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {

    var appModel = AppModel ()
    internal var AppId = String ()
    var linkApp = String ()
    
    @IBOutlet weak var svDetail: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgApp: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRights: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var vBody: UIView!
    @IBOutlet weak var vBodyiPad: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appModel = AppModel ()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "DETAIL"
        self.setDetailApp ()
    }
    
    func setDetailApp() -> Void {
        
        let appEntity = self.appModel.getEntityByNameId(AppId) as! AppEntity
        
        self.lblName.text = appEntity.name;
        
        Alamofire.request(.GET, appEntity.imageUrl!).response { (request, response, data, error) in
            self.imgApp.image = UIImage(data: data!, scale:1)
        }
        
        self.lblDescription.text = appEntity.summary;
        self.lblDate.text = appEntity.releaseDate;
        self.lblRights.text = appEntity.rights;
        
        if  (Float(appEntity.price!) == 0) {
            self.lblPrice.text = "Free"
        } else {
            let price = appEntity.price;
            let strPrice = "\(price) USD"
            self.lblPrice.text = strPrice
        
        }
        
        self.linkApp = appEntity.link!
        
        
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            
            self.vBody.layer.shadowColor = UIColor.blackColor().CGColor
            self.vBody.layer.shadowOffset = CGSizeZero
            self.vBody.layer.shadowOpacity = 0.5
            self.vBody.layer.shadowRadius = 5
            
            self.vBody.layer.cornerRadius = 10.0
            self.vBody.layer.borderColor = UIColor.grayColor().CGColor
            self.vBody.layer.borderWidth = 0.5
            self.vBody.clipsToBounds = true
            
            break
        case .Pad:
            
            self.vBodyiPad.layer.shadowColor = UIColor.blackColor().CGColor
            self.vBodyiPad.layer.shadowOffset = CGSizeZero
            self.vBodyiPad.layer.shadowOpacity = 0.5
            self.vBodyiPad.layer.shadowRadius = 5
            
            self.vBodyiPad.layer.cornerRadius = 10.0
            self.vBodyiPad.layer.borderColor = UIColor.grayColor().CGColor
            self.vBodyiPad.layer.borderWidth = 0.5
            self.vBodyiPad.clipsToBounds = true
            
            break
        default:
            break
        }
        
        self.svDetail.contentSize = CGSize (width: self.view.frame.size.width, height: self.lblPrice.frame.origin.y + self.lblPrice.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openStore(sender: AnyObject) {
        let url = NSURL(string: self.linkApp)!
        UIApplication.sharedApplication().openURL(url)
    }
    

}

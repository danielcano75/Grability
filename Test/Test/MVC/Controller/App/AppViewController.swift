//
//  AppViewController.swift
//  Test
//
//  Created by Daniel Cano on 12/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AppViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var appModel = AppModel ()
    
    @IBOutlet weak var tvApps: UITableView!
    @IBOutlet weak var cvApps: UICollectionView!
    
    internal var categoryID = String()
    internal var Category = String ()
    var applications = NSArray ()
    var _appId = String ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appModel = AppModel ()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.applications = self.appModel.getAppsByCategoryID(categoryID)
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            
            self.title = self.Category
            self.tvApps.reloadData()
            if self.cvApps != nil {
                self.cvApps.removeFromSuperview()
            }
            
            break
        case .Pad:
            
            self.title = "APLICATIONS"
            self.cvApps.reloadData()
            if self.tvApps != nil {
                self.tvApps.removeFromSuperview()
            }
            
            break
        default:
            break
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.applications.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AppCollectionCell
        
        let entity = self.applications[indexPath.row] as! AppEntity
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.lblApp.text = entity.name
        cell.lblCategory.text = self.Category
        
        cell.vApp.layer.shadowColor = UIColor.blackColor().CGColor
        cell.vApp.layer.shadowOffset = CGSizeZero
        cell.vApp.layer.shadowOpacity = 0.5
        cell.vApp.layer.shadowRadius = 5
        
        cell.vApp.layer.cornerRadius = 10.0
        cell.vApp.layer.borderColor = UIColor.grayColor().CGColor
        cell.vApp.layer.borderWidth = 0.5
        cell.vApp.clipsToBounds = true
        
        Alamofire.request(.GET, entity.imageUrl!).response { (request, response, data, error) in
            cell.icnApp.image = UIImage(data: data!, scale:1)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let entity = self.applications[indexPath.row] as! AppEntity
        _appId = entity.id!;
        self.performSegueWithIdentifier("Detail", sender: nil)
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.applications.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AppTableCell
        
        let entity = self.applications[indexPath.row] as! AppEntity
        
        cell.lblApp.text = entity.name
        Alamofire.request(.GET, entity.imageUrl!).response { (request, response, data, error) in
            cell.icnApp.image = UIImage(data: data!, scale:1)
        }
            
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let entity = self.applications[indexPath.row] as! AppEntity
        _appId = entity.id!;
        self.performSegueWithIdentifier("Detail", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailView:DetailViewController = segue.destinationViewController as! DetailViewController
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        detailView.AppId = _appId
        
    }

}

//
//  CategoryViewController.swift
//  Test
//
//  Created by Daniel Cano on 12/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var syncModel = SyncModel ()
    var categoryModel = CategoryModel ()
    var loading = LoadingHUD ()
    var categoryID = String ()
    var category = String ()
    
    @IBOutlet weak var tvCategories: UITableView!
    @IBOutlet weak var cvCategories: UICollectionView!
    var categories = NSArray ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryModel = CategoryModel ()
        self.loading.showLoading(self.view)
        if Reachability.isConnectedToNetwork() == true {
            self.syncModel.SyncData { (success) -> Bool in
                
                if success {
                    
                    self.getCategoies();
                    
                }
                
                return success
                
            }
        } else {
            var alert = UIAlertView(title: "Error de conexión", message: "debes tener conexión a internet para obtener los datos, intentalo de nuevo mas tarde", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            self.getCategoies();
        }
    }
    
    func getCategoies() -> Void {
        self.categories = self.categoryModel.getAll()
        self.loading.removeLoading(self.view)
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            
            self.tvCategories.reloadData()
            if self.cvCategories != nil {
                self.cvCategories.removeFromSuperview()
            }
            
            
            break
        case .Pad:
            
            self.cvCategories.reloadData()
            if self.tvCategories != nil {
                self.tvCategories.removeFromSuperview()
            }
            
            break
        default:
            break
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CategoryColletionCell
        
        let entity = self.categories[indexPath.row] as! CategoryEntity
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.lblCatecory.text = entity.name
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let entity = self.categories[indexPath.row] as! CategoryEntity
        self.categoryID = entity.id!
        self.category = entity.name!
        self.performSegueWithIdentifier("Apps", sender: nil)
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.categories.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategoryTableCell
        
        let entity = self.categories[indexPath.row] as! CategoryEntity
        
        cell.lblCatecory.text = entity.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let entity = self.categories[indexPath.row] as! CategoryEntity
        self.categoryID = entity.id!
        self.category = entity.name!
        self.performSegueWithIdentifier("Apps", sender: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let appView:AppViewController = segue.destinationViewController as! AppViewController
        appView.categoryID = self.categoryID
        appView.Category = self.category
        
    }
 

}

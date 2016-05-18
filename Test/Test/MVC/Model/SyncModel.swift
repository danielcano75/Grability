//
//  SyncModel.swift
//  Test
//
//  Created by Daniel Cano on 12/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class SyncModel: BaseModel {
    
    var category = CategoryModel ()
    var app = AppModel ()
    
    var categoryEntity = CategoryEntity ()
    var appEntity = AppEntity ()
        
    override init() {
        self.category = CategoryModel ()
        self.app = AppModel ()
        super.init()
    }
    
    internal func SyncData (succcess: Bool -> Bool) -> Void {
        
        let url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
        
        Alamofire.request(.GET, url).responseJSON { response in
            let json = JSON(response.result.value!)
            let feed = json["feed"].dictionary
            let entry = feed!["entry"]!.arrayValue
            
            self.syncApps(entry)
            succcess (true)
        }
        
        succcess (false)
        
    }
    
    internal func syncCategories(entity: [String : JSON]) -> Void {
        
        let catEntity = self.categoryEntity.createEntity("CategoryEntity") as! CategoryEntity
        catEntity.id = entity["im:id"]?.object as? String
        catEntity.name = entity["label"]?.object as? String
        
        let categories = self.category.getAll()
        
        if categories.count == 0 {
            self.category.insert(catEntity)
            self.category.save()
        }
        
        if !self.existingCategory(Int(catEntity.id!)!) {
            self.category.insert(catEntity)
        }
        self.category.save()
        
    }
    
    internal func existingCategory(catID: Int) -> Bool {
        
        let categories = self.category.getAll()
        
        for item in categories {
            
            if Int(item.id!!)! == catID {
                return true
            }
            
        }
        
        return false
        
    }
    
    internal func syncApps(entities: [JSON]) -> Void {
        
        if entities.count == 0 {
            return
        }
        
        for item in entities {
        
            let entity = self.appEntity.createEntity("AppEntity") as! AppEntity
        
            let packID = item["id"].dictionary
            let attrsID = packID!["attributes"]!.dictionary
            let name = item["im:name"].dictionary
            let images = item["im:image"].arrayValue
            let summary = item["summary"].dictionary
            let price = item["im:price"].dictionary
            let attrsPrice = price!["attributes"]!.dictionary
            let rights = item["rights"].dictionary
            let category = item["category"].dictionary
            let attrsCategory = category!["attributes"]!.dictionary
            let releaseDate = item["im:releaseDate"].dictionary
            let attrsReleaseDate = releaseDate!["attributes"]!.dictionary
            let link = item["link"].dictionary
            let attrLink = link["attributes"].dictionary
            
            self.syncCategories(attrsCategory!)
            
            entity.id = attrsID!["im:id"]!.object as? String
            entity.name = name!["label"]!.object as? String
            entity.summary = summary!["label"]!.object as? String
            entity.imageUrl = imageForApp(images).lastObject as? String
            entity.price = attrsPrice!["amount"]!.object as? String
            entity.rights = rights!["label"]!.object as? String
            entity.categoryId = attrsCategory!["im:id"]!.object as? String
            entity.releaseDate = attrsReleaseDate!["label"]!.object as? String
            entity.link = attrLink["href"].object as? String
            
            if !self.existingApplication(Int(entity.id!)!) {
                self.app.insert(entity)
            }
            
            self.app.save()
            
        }
        
    }
    
    internal func existingApplication(appID: Int) -> Bool {
        
        let applications = self.app.getAll()
        
        for item in applications {
            
            if Int(item.id!!)! == appID {
                return true
            }
            
        }
        
        return false
        
    }
    
    internal func imageForApp(images: [JSON]) -> NSArray {
        
        
        let all = NSMutableArray ()
        
        if images.count == 0 {
            return all
        }
        
        for item in images {
            
            let image = item["label"].object
            all.addObject(image)
            
        }
        
        return all
        
    }
    
}

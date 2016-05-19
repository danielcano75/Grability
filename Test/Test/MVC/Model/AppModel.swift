//
//  AppModel.swift
//  Test
//
//  Created by Daniel Cano on 15/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import CoreData

class AppModel: BaseModel {

    override func entityName() -> String {
        return "AppEntity"
    }
    
    internal func getAppsByCategoryID(categoryId: String) -> NSArray {
        let fetch = NSFetchRequest(entityName: self.entityName())
        let predicate = NSPredicate(format: "categoryId == %@",categoryId)
        fetch.predicate = predicate
        
        return self.executeFetch(fetch);
    }

}

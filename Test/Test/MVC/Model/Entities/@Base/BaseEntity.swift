//
//  BaseEntity.swift
//  Test
//
//  Created by Daniel Cano on 13/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import SwiftyJSON

class BaseEntity: NSManagedObject {
    
//    internal func parseObject(dic: [JSON]) -> NSManagedObject {
//        // Se debe heredar
//        return NSManagedObject ()
//    }
    
//    internal func parseObjects(array: NSArray) -> NSArray {
//        
//        let entities = NSMutableArray()
//        if array.count > 0 {
//            for dic in array {
//                entities.addObject(self.parseObject(dic as! [JSON]))
//            }
//        }
//        
//        return entities
//        
//    }
    
    internal func createEntity(entityName: String) -> AnyObject {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        let unassociatedObject = NSManagedObject.init(entity: entity!, insertIntoManagedObjectContext: nil)
        
        return unassociatedObject
        
    }
    
}

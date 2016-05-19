//
//  BaseModel.swift
//  Test
//
//  Created by Daniel Cano on 13/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import CoreData

class BaseModel: NSObject {

    var objectModel: NSManagedObjectModel
    var objectContext: NSManagedObjectContext
    
    override init() {
        
        self.objectModel = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectModel
        self.objectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
    }
    
    internal func entityName() -> String {
        // Se debe heredar
        return ""
    }
    
    internal func insert(entity: NSManagedObject) -> Void {
        self.objectContext.insertObject(entity)
        self.save()
    }
    
    internal func deleteEntity(entity: NSManagedObject) -> Void {
        self.objectContext.deleteObject(entity);
        self.save()
    }
    
    internal func getAll() -> NSArray {
        return self.getAll(self.entityName())
    }
    
    internal func getEntityByNameId(entityId: String) -> AnyObject {
        let fetch = NSFetchRequest(entityName: self.entityName())
        let predicate = NSPredicate(format: "id == %@",entityId)
        fetch.predicate = predicate
        
        return self.scalarFetch(fetch)
    }
    
    internal func getAll(entityName: String) -> NSArray {
        let request = NSFetchRequest(entityName: entityName)
        return self.executeFetch(request)
    }
    
    internal func deleteAll() -> Void {
        let entities = self.getAll()
        for entity in entities {
            self.objectContext .deleteObject(entity as! NSManagedObject)
        }
        self.save()
    }

    internal func executeFetch(request: NSFetchRequest) -> NSArray {
        do {
            let fetched = try self.objectContext.executeFetchRequest(request) as! [NSFetchRequest]
            return fetched
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }

    internal func scalarFetch(request: NSFetchRequest) -> NSManagedObject {
        request.fetchLimit = 1;
        let array = self.executeFetch(request)
        if array.count == 0 {
            return NSManagedObject ()
        }
        return array.objectAtIndex(0) as! NSManagedObject
    }
    
    internal func save() -> Void {
        do {
            try self.objectContext.save()
        } catch {
            print("Error al guardar")
            abort()
        }
    }
    
}


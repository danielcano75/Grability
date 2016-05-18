//
//  AppEntity+CoreDataProperties.swift
//  Test
//
//  Created by Daniel Cano on 5/18/16.
//  Copyright © 2016 Daniel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AppEntity {

    @NSManaged var categoryId: String?
    @NSManaged var id: String?
    @NSManaged var imageUrl: String?
    @NSManaged var name: String?
    @NSManaged var price: String?
    @NSManaged var releaseDate: String?
    @NSManaged var rights: String?
    @NSManaged var summary: String?
    @NSManaged var link: String?

}

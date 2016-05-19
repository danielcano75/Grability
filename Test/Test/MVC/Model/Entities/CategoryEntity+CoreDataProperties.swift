//
//  CategoryEntity+CoreDataProperties.swift
//  Test
//
//  Created by Daniel Cano on 15/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CategoryEntity {

    @NSManaged var id: String?
    @NSManaged var name: String?

}

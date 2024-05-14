//
//  CDEmployee+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: Data?
    @NSManaged public var toPassport: CDPassport?

}

extension CDEmployee : Identifiable {

}

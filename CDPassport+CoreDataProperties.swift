//
//  CDPassport+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//
//

import Foundation
import CoreData


extension CDPassport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPassport> {
        return NSFetchRequest<CDPassport>(entityName: "CDPassport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var passportId: String?
    @NSManaged public var placeOfIssue: String?
    @NSManaged public var toEmployee: CDEmployee?

}

extension CDPassport : Identifiable {

}

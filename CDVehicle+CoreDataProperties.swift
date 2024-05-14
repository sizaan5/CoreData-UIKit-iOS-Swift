//
//  CDVehicle+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//
//

import Foundation
import CoreData


extension CDVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVehicle> {
        return NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var toEmployee: CDEmployee?

}

extension CDVehicle : Identifiable {

}

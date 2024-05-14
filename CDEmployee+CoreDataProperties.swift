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
    @NSManaged public var toVehicle: Set<CDVehicle>?

}

// MARK: Generated accessors for toVehicle
extension CDEmployee {

    @objc(addToVehicleObject:)
    @NSManaged public func addToToVehicle(_ value: CDVehicle)

    @objc(removeToVehicleObject:)
    @NSManaged public func removeFromToVehicle(_ value: CDVehicle)

    @objc(addToVehicle:)
    @NSManaged public func addToToVehicle(_ values: Set<CDVehicle>)

    @objc(removeToVehicle:)
    @NSManaged public func removeFromToVehicle(_ values: Set<CDVehicle>)

}

extension CDEmployee : Identifiable {

}

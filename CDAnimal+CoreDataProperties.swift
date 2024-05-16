//
//  CDAnimal+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//
//

import Foundation
import CoreData


extension CDAnimal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAnimal> {
        return NSFetchRequest<CDAnimal>(entityName: "CDAnimal")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: URL?
    @NSManaged public var name: String?

}

extension CDAnimal : Identifiable {

}

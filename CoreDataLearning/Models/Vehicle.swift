//
//  Vehicle.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

class Vehicle {
    let id: UUID
    let name, type: String
    let ownerName: String?

    init(_id: UUID, _name: String, _type: String, _ownerName: String? = nil)
    {
        self.id = _id
        self.name = _name
        self.type = _type
        self.ownerName = _ownerName
    }
}

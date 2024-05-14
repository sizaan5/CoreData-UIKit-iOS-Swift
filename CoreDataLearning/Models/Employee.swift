//
//  Employee.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import Foundation

class Employee {
    let id: UUID
    let name, email: String
    let profilePicture: Data
    var passport: Passport?
    var vehicles: [Vehicle]?

    init(_id: UUID, _name: String, _email: String, _profilePicture: Data, _passport: Passport? = nil, _vehicles: [Vehicle]? = nil) {

        self.id = _id
        self.name = _name
        self.email = _email
        self.passport = _passport
        self.profilePicture = _profilePicture
        self.vehicles = _vehicles
    }
}

//
//  Passport.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import Foundation

class Passport {
    let id: UUID
    let passportId, placeOfIssue, name: String?

    init(_id: UUID, _passportId: String?, _placeOfIssue: String?, _name: String? = nil)
    {
        self.id = _id
        self.name = _name
        self.placeOfIssue = _placeOfIssue
        self.passportId = _passportId
    }
}

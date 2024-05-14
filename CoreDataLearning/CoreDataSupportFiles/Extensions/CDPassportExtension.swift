//
//  CDPassportExtension.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

extension CDPassport {
    func convertToPassport() -> Passport? {
        return Passport(_id: (self.id)!, _passportId: self.passportId, _placeOfIssue: self.placeOfIssue, _name: self.toEmployee?.name)
    }
}

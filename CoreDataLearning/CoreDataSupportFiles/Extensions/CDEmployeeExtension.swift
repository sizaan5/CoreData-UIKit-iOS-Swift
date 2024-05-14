//
//  CDEmployeeExtension.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

extension CDEmployee {
    func convertToEmployee() -> Employee {
        return Employee(_id: (self.id)!, _name: self.name!, _email: self.email!, _profilePicture: self.profilePic!, _passport: self.toPassport?.convertToPassport())
    }
}

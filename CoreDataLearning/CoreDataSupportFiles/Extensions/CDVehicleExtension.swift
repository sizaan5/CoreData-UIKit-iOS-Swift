//
//  CDVehicleExtension.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

extension CDVehicle {
    func convertToVehicle() -> Vehicle {
        return Vehicle(_id: self.id!, _name: self.name!, _type: self.type!)
    }
}

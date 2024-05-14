//
//  VehicleManager.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

struct VehicleManager {
    private let _vehicleDataRepository = VehicleDataRepository()
    
    func createVehicle(record: Vehicle) {
        _vehicleDataRepository.create(record: record)
    }

    func getAll() -> [Vehicle]? {
        return _vehicleDataRepository.getAll()
    }
}

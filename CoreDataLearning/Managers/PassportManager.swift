//
//  PassportManager.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

struct PassportManager {
    
    private let _passportRepository : PassportDataRepository = PassportDataRepository()
    
    func create(record: Passport)
    {
        _passportRepository.create(record: record)
    }
    
    func getAllPassports() -> [Passport]?
    {
        return _passportRepository.getAll()
    }
    
    func deleteEmployee(byIdentifier id: UUID) -> Bool
    {
        return _passportRepository.delete(byIdentifier: id)
    }
}

//
//  EmployeeManager.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import Foundation

struct EmployeeManager {
    private let _employeeRepository : EmployeeDataRepository = EmployeeDataRepository()
    
    func create(record: Employee) {
        if(validatePassport(passport: record.passport) == false) {
            record.passport = nil
        }
        _employeeRepository.create(record: record)
    }
    
    func getAllEmployee() -> [Employee]? {
        return _employeeRepository.getAll()
    }
    
    func getEmployee(byIdentifier id: UUID) -> Employee? {
        return _employeeRepository.get(byIdentifier: id)
    }
    
    func deleteEmployee(byIdentifier id: UUID) -> Bool {
        return _employeeRepository.delete(byIdentifier: id)
    }
    
    func updateEmployee(record: Employee) -> Bool {
        return _employeeRepository.update(record: record)
    }
    
    private func validatePassport(passport: Passport?) -> Bool {
        if(passport == nil || passport?.passportId?.isEmpty == true || passport?.placeOfIssue?.isEmpty == true) {
            return false
        }
        return true
    }
}

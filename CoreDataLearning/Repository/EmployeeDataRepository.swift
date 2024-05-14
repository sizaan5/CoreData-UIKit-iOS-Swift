//
//  EmployeeDataRepository.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import Foundation
import CoreData

protocol EmployeeRepository: BaseRepository {
}

struct EmployeeDataRepository: EmployeeRepository {
    func create(record: Employee) {
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.id = record.id
        cdEmployee.email = record.email
        cdEmployee.name = record.name
        cdEmployee.profilePic = record.profilePicture

        if(record.passport != nil) {
            let cdPassport = CDPassport(context: PersistentStorage.shared.context)
            cdPassport.placeOfIssue = record.passport?.placeOfIssue
            cdPassport.passportId = record.passport?.passportId
            cdPassport.id = record.passport?.id

            cdEmployee.toPassport = cdPassport
        }
        
        if(record.vehicles != nil && record.vehicles?.count != 0) {
            var vehicleSet = Set<CDVehicle>()
            record.vehicles?.forEach({ (vehicle) in
                let cdVehicle = CDVehicle(context: PersistentStorage.shared.context)
                cdVehicle.id = vehicle.id
                cdVehicle.type = vehicle.type
                cdVehicle.name = vehicle.name
                
                vehicleSet.insert(cdVehicle)
            })
            cdEmployee.toVehicle = vehicleSet
        }
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [Employee]? {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [Employee] = []
        records!.forEach({ (cdEmployee) in
            results.append(cdEmployee.convertToEmployee())
        })

        return results
    }

    func get(byIdentifier id: UUID) -> Employee? {
        let result = self.getCdEmployee(byId: id)
        guard result != nil else {return nil}

        return result!.convertToEmployee()
    }

    func update(record: Employee) -> Bool {
        let cdEmployee = self.getCdEmployee(byId: record.id)
        guard cdEmployee != nil else {return false}

        cdEmployee?.email = record.email
        cdEmployee?.name = record.name
        cdEmployee?.profilePic = record.profilePicture

        cdEmployee?.toPassport?.placeOfIssue = record.passport?.placeOfIssue
        cdEmployee?.toPassport?.passportId = record.passport?.passportId

        PersistentStorage.shared.saveContext()

        return true
    }

    func delete(byIdentifier id: UUID) -> Bool {
        let employee = getCdEmployee(byId: id)
        guard employee != nil else {return false}

        PersistentStorage.shared.context.delete(employee!)
        PersistentStorage.shared.saveContext()

        return true
    }

    private func getCdEmployee(byId id: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }

    typealias T = Employee
}

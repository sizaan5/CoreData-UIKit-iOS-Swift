//
//  AnimalDataRepository.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//

import Foundation

protocol AnimalBaseRepository {
    func getAnimalRecords(completionHandler:@escaping(_ result: Array<Animal>?)->Void)
}

protocol AnimalCoreDataRepository : AnimalBaseRepository {
    func insertAnimalRecords(records:Array<Animal>) -> Bool
}

protocol AnimalApiResourceRepository : AnimalBaseRepository {
    
}

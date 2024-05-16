//
//  CDAnimalExtension.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//

import Foundation

extension CDAnimal {
    func convertToAnimal() -> Animal {
        return Animal(name: self.name!, image: self.image!)
    }
}

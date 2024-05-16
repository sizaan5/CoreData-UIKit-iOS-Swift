//
//  Animal.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//

import Foundation

struct AnimalResponse: Decodable {
    let errorMessage: String?
    let animals: [Animal]?

    enum CodingKeys: String, CodingKey {
        case animals = "data"
        case errorMessage
    }
}

struct Animal: Decodable {
    let name: String
    let image: URL
}

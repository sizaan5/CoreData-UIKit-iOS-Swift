//
//  BaseRepository.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import Foundation

protocol BaseRepository {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: UUID) -> Bool
}

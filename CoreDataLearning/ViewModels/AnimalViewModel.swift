//
//  AnimalViewModel.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//

import Foundation

struct AnimalViewModel {

    private let _cdAnimalDataRepository: AnimalCoreDataRepository = AnimalDataRepository()
    private let _animalApiRepository: AnimalApiResourceRepository = AnimalApiRepository()

    func getAnimalRecord(completionHandler:@escaping(_ result: Array<Animal>?)-> Void) {

        _cdAnimalDataRepository.getAnimalRecords { response in
            if(response != nil && response?.count != 0){
                // return response to the view controller
                completionHandler(response)
            }else {
                // call the api
                _animalApiRepository.getAnimalRecords { apiResponse in
                    if(apiResponse != nil && apiResponse?.count != 0){
                        // insert record in core data
                      _ = _cdAnimalDataRepository.insertAnimalRecords(records: apiResponse!)
                        debugPrint("AnimalViewModel: Returning records to view controller")
                        completionHandler(apiResponse)
                    }
                }
            }
        }

    }
}

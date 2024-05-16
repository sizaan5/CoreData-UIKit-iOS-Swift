//
//  AnimalApiRepository.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 15/05/2024.
//

import Foundation

struct AnimalApiRepository: AnimalApiResourceRepository {

    func getAnimalRecords(completionHandler: @escaping (Array<Animal>?) -> Void) {

        URLSession.shared.dataTask(with: ApiResource.animalResource) { (data, response, error) in
            if(error == nil && data != nil) {
                do {
                    // deocding the response
                    let result = try JSONDecoder().decode(AnimalResponse.self, from: data!)
                    if(result.errorMessage?.isEmpty == true) {
                        completionHandler(result.animals) // sending decoded response back
                    }else{
                        debugPrint("error in response, please contact codecat15")
                    }

                } catch let error {
                    debugPrint(error)
                }
            }

        }.resume()
    }
}

struct ApiResource {
    static let animalResource : URL = URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/Animal/GetAnimals")!
}

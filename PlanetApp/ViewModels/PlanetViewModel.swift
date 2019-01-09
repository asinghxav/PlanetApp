//
//  PlanetViewModel.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 08/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation


class PlanetViewModel {
    
    weak var view: PlanetView?
    var items:[PlanetModelPresentable] = []
    
    typealias JSONDictionary = [String: Any]
    
    var errorMessage = ""
    
    init(view: PlanetView) {
        self.view = view
    }
    
    func callPlanetListAPI()  {
        loadPlanetListFromServer()
    }
    
    // Fetch data from local DB to show list of planets
    func fetchPlanetListfromDB() {
        
        if let arrOfPlanets = DBmanger.instance.fetchPlanetInfo()
        {
           items = arrOfPlanets
           self.view?.reloadTableView()
        }
        
    }
    
    // API call to fetch planets data from server
    private func loadPlanetListFromServer() {
        
        var response: JSONDictionary?
        
        self.view?.showActivityIndicator()
        PlanetAPIService.getPlanetList(completion: { (data, error) in
            
            if let responseData = data {
                do {
                    response = try JSONSerialization.jsonObject(with: responseData, options: []) as? JSONDictionary
                } catch let parseError as NSError {
                    self.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                    print(self.errorMessage)
                    return
                }
                
                guard let array = response!["results"] as? [Any] else {
                    self.errorMessage += "Dictionary does not contain results key\n"
                    print(self.errorMessage)
                    return
                }
                
                // Delete all data in DB before saving data to local DB to avoid duplicacy of data
                DBmanger.instance.deleteAllData(entity: DBmanger.CoreDataEntityName.planetInfo.rawValue)
                
                // Saving data to local DB to see the planet list in offline mode also
                for resultDictionary in array {
                    
                    if let trackDictionary = resultDictionary as? JSONDictionary,
                        let name = trackDictionary["name"] as? String {
                        DBmanger.instance.savePlanetInfo(planetModel: PlanetModel(name: name))
                    } else {
                        self.errorMessage += "Problem parsing trackDictionary\n"
                        print(self.errorMessage)
                    }
                }
                
            }else {
                if let err = error {
                    self.errorMessage += err.localizedDescription
                    print(self.errorMessage)
                }
            }
            self.fetchPlanetListfromDB()
            self.view?.hideActivityIndicator()

        })
    }
}



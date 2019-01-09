//
//  DBmanger.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 08/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation
import CoreData

class DBmanger {
    
    enum CoreDataEntityName: String
    {
        case planetInfo = "PlanetInfo"
    }
    
    private let dbName = "PlanetApp"
    static let instance = DBmanger()
    
    private init(){
        
    }
    
    /// Managed Context for Core Data
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dbName)
        //print(container.persistentStoreDescriptions)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // fatalError("Unresolved error \(error), \(error._userInfo)")
            }
        })
        
        return container
    }()
    
    /// This will return a new `insertNewObject` instance of type NSManagedObject
    /// that can be casted down into Context, Location or Task and then to be
    /// used to create a new record to the database.
    
    private func getEntityDescriptionNewObject(withEntityName name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: managedObjectContext())
    }
    
    /// Function used to retrieve all the available records of the given Entity.
    /// This code is applicable to allContexts, allTasks and allLocations therefore
    /// wrapped into a single method for reuse.
    ///
    /// - Parameters:
    ///     - for: The name of the Entity to query.
    ///
    /// - Returns: Results (Any) or nil if nothing found or something went wrong
    private func getAllEntries(for name: String) -> Any?
    {
        let fetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
        
        do {
            return try managedObjectContext().fetch(fetch)
        }
        catch {
            fatalError("Failed to fetch tasks: \(error)")
        }
        
        return nil
    }
    
    private func saveOrUpdate(instance: NSManagedObject) -> Bool
    {
        do
        {
            try instance.managedObjectContext?.save()
            return true
        }
        catch
        {
            fatalError("Failed to save or update \(error)")
        }
        return false
    }
    
    func fetchPlanetInfo() ->[PlanetModel]?
    {
        if let planetInfoEntries:[PlanetInfo] = self.getAllEntries(for: CoreDataEntityName.planetInfo.rawValue) as? [PlanetInfo]
        {
            var arrOfPlanetInfo = [PlanetModel]()
            
            for entry in planetInfoEntries
            {
                if  let name = entry.planetName {
                    let planetInfo = PlanetModel(name: name)
                    arrOfPlanetInfo.append(planetInfo)
                }
            }
            return arrOfPlanetInfo
        }
        return nil
    }
    
    func savePlanetInfo(planetModel: PlanetModel)
    {
        let planetInfo = self.getEntityDescriptionNewObject(withEntityName: CoreDataEntityName.planetInfo.rawValue) as! PlanetInfo
        planetInfo.planetName = planetModel.name
        
        let _ = self.saveOrUpdate(instance: planetInfo)
    }
    
    func deleteAllData(entity: String)
    {
        let reqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: reqVar)
        do { try managedObjectContext().execute(DelAllReqVar) }
        catch { print(error) }
    }
    
}


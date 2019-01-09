//
//  PlanetInfo+CoreDataProperties.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 09/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension PlanetInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetInfo> {
        return NSFetchRequest<PlanetInfo>(entityName: "PlanetInfo")
    }

    @NSManaged public var planetName: String?

}

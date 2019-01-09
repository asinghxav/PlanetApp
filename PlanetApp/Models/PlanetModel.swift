//
//  PlanetModel.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 08/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation


protocol PlanetModelPresentable {
    
    var name: String?{get}
    var rotationPeriod: String?{get}
    var orbitalPeriod: String?{get}
    var diameter: String?{get}
    var climate: String?{get}
    var gravity: String?{get}
    var terrain: String?{get}
    var surface_water: String?{get}
    var population: String?{get}
    var residents: [String]?{get}
    var films: [String]?{get}
    var created: String?{get}
    var edited: String?{get}
    var url: String?{get}

}

class PlanetModel: PlanetModelPresentable {
   
    var name: String?
    
    var rotationPeriod: String?
    
    var orbitalPeriod: String?
    
    var diameter: String?
    
    var climate: String?
    
    var gravity: String?
    
    var terrain: String?
    
    var surface_water: String?
    
    var population: String?
    
    var residents: [String]?
    
    var films: [String]?
    
    var created: String?
    
    var edited: String?
    
    var url: String?
    
    init(name:String) {
        self.name = name
    }
    
}



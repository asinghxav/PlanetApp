//
//  PlanetAPIService.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 07/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation


typealias APICompletion = (_ data: Data?, _ error: Error?) -> ()

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

class PlanetAPIService {
    
    static let baseUrl:String = PlanetAPIUrls.baseUrl.rawValue
    
    static func getPlanetList(completion: @escaping APICompletion)
    {
        let urlString = String(format: "%@%@", arguments:[baseUrl, PlanetAPIUrls.getPlanetList.rawValue])
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        PlanetAppClient.request(request: request, completion: { success, data, error in
            
            if success
            {
                completion(data, nil)
                return
            }
            
            completion(nil, error)
            return
        })
    }
}

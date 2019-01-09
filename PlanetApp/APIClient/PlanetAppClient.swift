//
//  PlanetAppClient.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 07/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation


enum URLRequestError: Error
{
    case networkUnavailable
    case sessionExpired
    case otherError
    case noData
}

extension URLRequestError: LocalizedError {
    
    public var errorDescription: String? {
        switch self
        {
        case .networkUnavailable:
            return "Unable to complete network request. No Internet connection present."
        case .sessionExpired:
            return "Your session has expired."
        case .otherError:
            return "Server error. Please contact us."
        case .noData:
            return "Did not receive data."
        }
    }
}

class PlanetAppClient
{
    
    static let sharedInstance = PlanetAppClient()
    var urlSessionManager: URLSession?
    
    let timeOutInterval = 30.0
    private init()
    {
        if self.urlSessionManager == nil
        {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = timeOutInterval
            urlSessionManager = URLSession(configuration: configuration)
            
        }
    }
    
    static func request(request: URLRequest, completion:@escaping (_ success: Bool, _ data: Data?, _ error: Error?) -> ())
    {
        print("httpbody request: \(request)")
        
        if let sessionManager = PlanetAppClient.sharedInstance.urlSessionManager
        {
           let dataTask =  sessionManager.dataTask(with: request) { (data, response, error) in
                
                if let httpResponse = response
                {
                    switch httpResponse.getStatusCode()
                    {
                    case 200:
                        
                        guard let responseData = data else {
                            let error: Error = URLRequestError.noData
                            DispatchQueue.main.async(execute: { () -> Void in
                                completion(false, nil, error)
                            })
                            print("Error: did not receive data")
                            return
                        }
                        
                        print("Data received")
                        DispatchQueue.main.async(execute: { () -> Void in
                            completion(true, responseData, nil)
                        })
                        break
                        
                    case 401:
                        
                        let error = URLRequestError.sessionExpired
                        DispatchQueue.main.async(execute: { () -> Void in
                            completion(false, nil, error)
                        })
                        return
                        
                    default:
                        
                        let error = URLRequestError.otherError
                        DispatchQueue.main.async(execute: { () -> Void in
                            completion(false, nil, error)
                        })
                        return
                    }
                } else {
                    let error = URLRequestError.otherError
                    DispatchQueue.main.async(execute: { () -> Void in
                        completion(false, nil, error)
                    })
                    return
                }
            }
            
            dataTask.resume()
            
        } else
        {
            let error: Error = URLRequestError.otherError
            DispatchQueue.main.async(execute: { () -> Void in
                completion(false, nil, error)
            })
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

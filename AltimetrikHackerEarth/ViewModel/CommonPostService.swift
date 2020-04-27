//
//  CommonPostService.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation

public class CommonPostService {
    
    class var sharedInstance: CommonPostService {
        struct Singleton { static let instance = CommonPostService() }
        return Singleton.instance
    }
    
    func callSomeMethodWithParams(request : URLRequest , daoSuccessCallback: @escaping (Data)->(), daoErrorCallback: @escaping (_ JSON: Any)->()) {
        
        let methodStart = Date()
        
        /* URL Session */
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                daoErrorCallback(Constants.errorCode.serverNotReachable.rawValue)
                return
            }
            
            guard let data = data else {
                daoErrorCallback(Constants.errorCode.dataFailure.rawValue)
                return
            }
            
            do {
                let methodFinish = Date()
                let executionTime = methodFinish.timeIntervalSince(methodStart)
                print("MakeServiceCall -> Execution time: \(executionTime)")
                
                
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//                if let jsondata = json {
                    daoSuccessCallback(data)
                //}
            }
        }
        task.resume()
        
    }
}

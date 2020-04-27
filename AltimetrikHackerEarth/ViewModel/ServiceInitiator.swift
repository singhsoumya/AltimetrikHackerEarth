//
//  ServiceInitiator.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation
import UIKit

class ServiceInitiator {
    
    func getStarLordData(callback: @escaping (Data)->(),errorCallback: @escaping (String)->())
    {
        
        let urlString = Constants.WEBSERVICES.BASE_URL
        
        let url = URL(string: urlString)!
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        CommonPostService.sharedInstance.callSomeMethodWithParams(request: request, daoSuccessCallback: { (jsonData) in
            
            callback(jsonData)
            
        }, daoErrorCallback: { (error) in
            print(error)
            errorCallback(Constants.errorCode.dataFailure.rawValue)
        })
        
    }
}

//
//  AppDataParser.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation

class AppDataParser {
    func getStarLordData(callback: @escaping ([StarLordDataModel])->(),errorCallback: @escaping (String)->())
    {
        if(Connection.isConnectedToNetwork()){
            
            ServiceInitiator().getStarLordData(callback: { (json) in
                
                if let dataModel = try? JSONDecoder.init().decode([StarLordDataModel].self, from: json){
                    
                    DispatchQueue.main.async {
                        DataBaseManager.sharedInstance().saveStarLordJsonData(jsonData: json, callback: { (success) in
                            
                        }) { (error) in
                            
                        }
                        
                        
                        callback(dataModel)
                    }
                }
                else{
                    errorCallback("Failure")
                }
    
                
                
            }, errorCallback: { (errorCode) in
                errorCallback(errorCode)
            })
        }
    }
    
    func fetchStarLordData(callback: @escaping ([StarLordDataModel])->(),errorCallback: @escaping (String)->())
        {
            DataBaseManager.sharedInstance().fetchStarLordJsonDataFromDB(callback: { (jsondata) in
                if let dataModel = try? JSONDecoder.init().decode([StarLordDataModel].self, from: jsondata){
                    callback(dataModel)
                }
                
            }, errorCallback: { (errorCode) in
                errorCallback(errorCode)
                
            })
            
        }
    
    
}

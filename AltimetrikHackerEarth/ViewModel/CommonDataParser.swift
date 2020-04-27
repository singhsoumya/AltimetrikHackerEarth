//
//  CommonDataParser.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation

class CommonDataParser {
    
    func getStarLordData(callback: @escaping ([StarLordDataModel])->(),errorCallback: @escaping (String)->()) {
        var commondata = [StarLordDataModel]()
        if(Connection.isConnectedToNetwork()){
            AppDataParser().getStarLordData(callback: { (jsonData) in
                
                
                commondata = jsonData
                callback(commondata)
                
            }) { (errorString) in
                errorCallback(errorString)
            }
            
        }else{
            AppDataParser().fetchStarLordData(callback: { (saveData) in
                commondata = saveData
                callback(commondata)
            }) { (errorString) in
                errorCallback(Constants.errorCode.dataFailure.rawValue)
            }
            
        }
        
    }
}

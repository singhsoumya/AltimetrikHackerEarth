//
//  DataBaseManager.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataBaseManager {
    
    static var instance: DataBaseManager!
       typealias downloadCompleted = (Bool) -> ()
       var successTran = false
       /**
        shared instance
        */
       class func sharedInstance() -> DataBaseManager {
           self.instance = (self.instance ?? DataBaseManager())
           return self.instance
       }
       
       func getManagedObjectContext() -> NSManagedObjectContext   {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           
           return appDelegate.persistentContainer.viewContext
       }
       
       func saveContext()  {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           return appDelegate.saveContext()
       }
       
}

extension DataBaseManager {
    
    func saveStarLordJsonData(jsonData : Data, callback: @escaping (String)->(),errorCallback: @escaping (String)->())
    {
        
        DataBaseManager.sharedInstance().deletePreviousJson()
        
        let context = self.getManagedObjectContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "StarLordDataBase", in: context)
        
        let DashBoardEntity = NSManagedObject(entity: entity!, insertInto: context)
    
        DashBoardEntity.setValue(jsonData, forKey: "jsonData")
       
        context.performAndWait({
            do {
                try context.save()
                callback(Constants.errorCode.success.rawValue)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                errorCallback(Constants.errorCode.failure.rawValue)
            } catch {
                errorCallback(Constants.errorCode.failure.rawValue)
            }
        })
        
    }
    
    func deletePreviousJson() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StarLordDataBase")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func fetchStarLordJsonDataFromDB( callback: @escaping (Data)->(),errorCallback: @escaping (String)->())
    {
        //getCountryJson
        // let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StarLordDataBase")
        
        var searchResults = [NSManagedObject]()
        do{
            searchResults = try self.getManagedObjectContext().fetch(fetchRequest) as! [NSManagedObject]
            
            if(searchResults.count>0)
            {
                callback(searchResults[0].value(forKey: "jsonData") as? Data ?? Data())
            }
            else{
                errorCallback("NoDataINStore")
            }
        }
        catch {
            print("Error with request: \(error)")
            errorCallback(Constants.errorCode.failure.rawValue)
        }
    }
}

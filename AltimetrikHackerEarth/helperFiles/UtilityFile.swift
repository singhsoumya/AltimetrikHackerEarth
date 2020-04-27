//
//  UtilityFile.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 27/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var backGroundImage: UIImage? {
        get {
            if let image = self.backGroundImage {
                return image
            }
            return nil
        }
        set {
            if let image = newValue {
                self.backgroundColor = UIColor(patternImage: image)
            } else {
                layer.backgroundColor = nil
            }
        }
    }
}

struct System {

    static func saveMediaFileToDirectory(mediaToSave: URL, fileName: String) {
           DispatchQueue.global(qos: .background).async {
               let videoURL = mediaToSave
               let videoData = NSData(contentsOf: videoURL )
               if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                print(documentsDirectory)
                   let fileURL = documentsDirectory.appendingPathComponent(fileName)
                   if FileManager.default.fileExists(atPath: fileURL.path) {
                       print("File already exist")
                       return
                   }
               }
               let path = try? FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
               if let newPath = path?.appendingPathComponent(fileName) {
                   do {
                       try videoData?.write(to: newPath)
                   } catch {
                       print(error)
                   }
                   
               }
           }
       }
    
    static func deleTeMediaFileToDirectory(fileName: String) {
        DispatchQueue.global(qos: .background).async {
            let filemanager = FileManager.default
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
            let destinationPath = documentsPath.appendingPathComponent(fileName)
            do {
                try filemanager.removeItem(atPath: destinationPath)
                print("Local path removed successfully")
            } catch let error as NSError {
                print("------Error",error.debugDescription)
            }
            
        }
    }
    
    static func getDownloadedMedia(fileName: String)-> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let dataPath = documentsDirectory + "/" + "\(fileName)"
        let checkValidation = FileManager.default
        if (checkValidation.fileExists(atPath: dataPath))
        {
            let filePathURL = URL(fileURLWithPath: dataPath)
            return filePathURL
        }
        return nil
    }
}

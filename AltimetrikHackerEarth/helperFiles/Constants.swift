//
//  Constants.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation

class Constants{
  
    public struct WEBSERVICES
    {
        static let BASE_URL = "http://starlord.hackerearth.com/kickstarter"
    }
    
    public enum StoryBoardKeys :  String {
        case STARLORD_DETAIL = "navigateTo_StarLordDetail"
        case STARLORD_LIST = "StarLordListViewController"
    }
    
    public enum errorCode : String
    {
        case failure = "failure"
        case success = "success"
        case serverNotReachable = "unReachableServer"
        case dataFailure = "dataFailure"
        case noData = "noData"
        
    }
  
    struct buttonText
    {
        static let ok = "OK"
        static let delete = "Delete"
        static let cancel = "Cancel"
        static let save = "Save"
    }
    
//    struct tutorialView
//    {
//        static let video = "Video"
//        static let audio = "Audio"
//        static let pdf = "PDF"
//        static let image = "Image"
//        static let download = "Download"
//    }
//
//    struct MoreView
//    {
//        static let library = "Library"
//        static let support = "Support"
//    }
//
//    struct downloadStatus
//    {
//        static let intialState = "intialState"
//        static let inProgress = "inProgress"
//        static let deleted = "deleted"
//        static let downloaded = "downloaded"
//        static let cancel = "cancel"
//    }
}


    

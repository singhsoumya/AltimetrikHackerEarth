//
//  SpinnerAlertView.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 27/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.white
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: Constants.buttonText.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func networkconnectivityAlertMessage(titleok:String, messageStr:String) {
        let alert = UIAlertController(title: titleok, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: Constants.buttonText.ok, style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction.init(title: Constants.buttonText.cancel, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


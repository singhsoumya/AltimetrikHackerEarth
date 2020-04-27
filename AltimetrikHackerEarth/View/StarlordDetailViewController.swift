//
//  starlordDetailViewController.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import UIKit

class StarlordDetailViewController: UIViewController {
    var dataModel = StarLordDataModel()
    
    @IBOutlet weak var noOfBackerslbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var fileName = ""
    var imageActivity = UIActivityIndicatorView(style: .medium)
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateUi() {
        titleLabel.text = dataModel.title
        descriptionLbl.text = dataModel.blurb
        amountLbl.text = "\(dataModel.amtPledged ?? 0)"
        noOfBackerslbl.text = dataModel.numBackers
        countrylbl.text = dataModel.country
        locationlbl.text = dataModel.location
        byLabel.text = dataModel.by
        if let imageUrl = dataModel.url , imageUrl != "" {
            let finalUrl = Constants.WEBSERVICES.BASE_URL + imageUrl
            if let imageDataUrl = URL(string: finalUrl) {
                fileName = "key" + "$" + finalUrl
                imageActivity.center = self.imageView.center
                imageActivity.startAnimating()
                imageActivity.isHidden = false
                imageView.addSubview(imageActivity)
                downloadImage(from: imageDataUrl)
            }
            
        }
        
    }

    func downloadImage(from url: URL) {
        if let imageURL = System.getDownloadedMedia(fileName: fileName) {
            let imageData = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async() {
                self.imageActivity.stopAnimating()
                self.imageActivity.isHidden = true
                if let imageFromData = UIImage(data: imageData ?? Data()) {
                    self.imageView.image = imageFromData
                }else {
                    self.imageView.image = UIImage(named: "imageNotFound")
                }
            }
        }else {
            if Connection.isConnectedToNetwork() {
                System.saveMediaFileToDirectory(mediaToSave: url, fileName: fileName)
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url.lastPathComponent)
                    DispatchQueue.main.async() {
                        self.imageActivity.stopAnimating()
                        self.imageActivity.isHidden = true
                        if let imageData = UIImage(data: data) {
                            self.imageView.image = imageData
                        }else {
                            self.imageView.image = UIImage(named: "imageNotFound")
                        }
                    }
                }
            }else {
                self.imageActivity.stopAnimating()
                self.imageActivity.isHidden = true
                self.imageView.image = UIImage(named: "imageNotFound")
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

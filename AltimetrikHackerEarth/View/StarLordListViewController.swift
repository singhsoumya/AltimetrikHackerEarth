//
//  ViewController.swift
//  AltimetrikHackerEarth
//
//  Created by Soumya, Singh on 26/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import UIKit

class StarLordListViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var starLordListTableview: UITableView!
    var resultSearchController = UISearchController()
    var dataList = [StarLordDataModel]()
    var masterDataList = [StarLordDataModel]()
    var filteredDataList = [StarLordDataModel]()
    var sv: UIView?
    var maxCount = 20
    let spinner = UIActivityIndicatorView(style: .medium)
    let countLabel = UILabel()
    var isFetchingMoreData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = ({ () -> UISearchController in
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            self.navigationController?.isNavigationBarHidden = true
            starLordListTableview.tableHeaderView = controller.searchBar

            return controller
        })()
        starLordListTableview.estimatedRowHeight = 60
        starLordListTableview.rowHeight = UITableView.automaticDimension
       getDataToUpdateUI()
    }

    func getDataToUpdateUI() {
        if sv == nil {
            sv = UIViewController.displaySpinner(onView: self.view)
        }
        CommonDataParser().getStarLordData(callback: { (jsonData) in
            self.masterDataList = jsonData
            if self.masterDataList.count > 0 {
                DispatchQueue.main.async {
                    if self.sv != nil {
                        UIViewController.removeSpinner(spinner: self.sv!)
                        self.sv = nil
                    }
                    for index in 0..<self.maxCount {
                        self.dataList.append(self.masterDataList[index])
                    }
                    self.starLordListTableview.reloadData()
                }
            }
            
        }) { (errorString) in
            DispatchQueue.main.async {
                if self.sv != nil {
                    UIViewController.removeSpinner(spinner: self.sv!)
                    self.sv = nil
                }
                self.starLordListTableview.reloadData()
                
            }
        }
    }

    func getTotalCount() -> Int {
        var numberOfResults = 0
        if let numberOfsec = starLordListTableview?.numberOfSections {
            for i in 0..<numberOfsec {
                let numberOfRows = starLordListTableview?.numberOfRows(inSection: i)
                numberOfResults = numberOfResults + (numberOfRows ?? 0)
            }
            
        }
        return numberOfResults
    }
    
    func beginBatchFetch() {
        let startIndex = maxCount
        maxCount = maxCount + 20
        if maxCount <= masterDataList.count {
            for index in startIndex..<maxCount {
                dataList.append(masterDataList[index])
            }
        }else if startIndex < masterDataList.count {
            for index in startIndex..<masterDataList.count {
                dataList.append(masterDataList[index])
            }
            
        }else {
            isFetchingMoreData = true
        }
        starLordListTableview.reloadData()
    }
}

extension StarLordListViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if  (resultSearchController.isActive) {
            return filteredDataList.count
        }else {
            return dataList.count
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? StarLordDataCell {
            if  (resultSearchController.isActive) {
                let eachStarData = filteredDataList[indexPath.row]
                cell.titleLabel.text = eachStarData.title
                cell.descriptionLabel.text = eachStarData.blurb
                cell.pleageAmount.text = "\(eachStarData.amtPledged ?? 0)"
                cell.noOfbackers.text = eachStarData.numBackers
            }else {
                let eachStarData = dataList[indexPath.row]
                cell.titleLabel.text = eachStarData.title
                cell.descriptionLabel.text = eachStarData.blurb
                cell.pleageAmount.text = "\(eachStarData.amtPledged ?? 0)"
                cell.noOfbackers.text = eachStarData.numBackers
            }
            return cell
        }
        return UITableViewCell()
    }


   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryBoardKeys.STARLORD_DETAIL.rawValue) as?  StarlordDetailViewController {
                if  (resultSearchController.isActive) {
                } else{
                    vc.dataModel = dataList[indexPath.row]
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        
    }

    func updateSearchResults(for searchController: UISearchController) {
        filteredDataList.removeAll(keepingCapacity: false)
        filteredDataList =  dataList.filter{ $0.title!.contains(searchController.searchBar.text!)
        }
        self.starLordListTableview.reloadData()
    }
    
        
    

   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
   countLabel.isHidden = true
   let lastSectionIndex = tableView.numberOfSections - 1
   let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1

       if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
           spinner.isHidden = false
           spinner.startAnimating()
           spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
           self.starLordListTableview?.tableFooterView = spinner
           self.starLordListTableview?.tableFooterView?.isHidden = false
           if maxCount != 0 , getTotalCount() + 1 > maxCount {
                   if !isFetchingMoreData {
                       beginBatchFetch()
                   }
           }else {
               spinner.stopAnimating()
               spinner.isHidden = true
               if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                   countLabel.isHidden = false
                   countLabel.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                   let rowCount = getTotalCount()
                   countLabel.textAlignment = .center
                   countLabel.font = UIFont.init(name: "HoneywellSansTT-Bold", size: 16.0 )
                   countLabel.isHidden = false
                   countLabel.text = "Total Count \(rowCount)"
                   self.starLordListTableview?.tableFooterView = countLabel
                   self.starLordListTableview?.tableFooterView?.isHidden = false
               }
           }
       }

    }

    
    
}

class StarLordDataCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pleageAmount: UILabel!
    @IBOutlet weak var noOfbackers: UILabel!
}

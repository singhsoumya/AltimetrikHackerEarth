//
//  StarLordListViewControllerTestsCases.swift
//  AltimetrikHackerEarthTests
//
//  Created by Soumya, Singh on 27/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import XCTest
@testable import AltimetrikHackerEarth

class StarLordListViewControllerTestsCases: XCTestCase {
    
    var viewController : StarLordListViewController?
    
    override func setUp() {
        viewController = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryBoardKeys.STARLORD_LIST.rawValue) as!  StarLordListViewController)
        
        viewController!.loadView()
        
        
    }
    
    override func tearDown() {
        viewController = nil
    }
    
    func testTableviewNumberOfRowToDisplayNumberofRowsInTableview() {
        var mockTestData = StarLordDataModel()
        mockTestData.title = "hackerearth"
        mockTestData.blurb = "hackerearth blurb"
        var mockArray = [StarLordDataModel]()
        mockArray.append(mockTestData)
        viewController?.dataList = mockArray
        
        viewController?.viewDidLoad()
        
        XCTAssertEqual(viewController?.tableView(viewController!.starLordListTableview, numberOfRowsInSection: 0), mockArray.count)
    }
    
    func testTableViewCellForRowAtIndexTODisplayTableData() {
        var mockTestData = StarLordDataModel()
        mockTestData.title = "hackerearth"
        mockTestData.blurb = "hackerearth blurb"
        var mockArray = [StarLordDataModel]()
        mockArray.append(mockTestData)
        viewController?.dataList = mockArray
        let index = IndexPath(row: 0, section: 0)
        
        viewController?.viewDidLoad()
        
        XCTAssertNotNil(viewController?.tableView(viewController!.starLordListTableview, cellForRowAt: index))
    }
    
    func testUpdateSearchResultsToShowSearchResultList() {
        var mockTestData = StarLordDataModel()
        mockTestData.title = "hackerearth"
        mockTestData.blurb = "hackerearth blurb"
        var mockTestData1 = StarLordDataModel()
        mockTestData1.title = "hackerearth1"
        mockTestData1.blurb = "hackerearth blurb1"
        var mockArray = [StarLordDataModel]()
        mockArray.append(mockTestData)
         mockArray.append(mockTestData1)
        viewController?.dataList = mockArray
        
        viewController?.resultSearchController.searchBar.text = "hackerearth1"

        viewController?.updateSearchResults(for: viewController!.resultSearchController)
        XCTAssertEqual(viewController?.filteredDataList.count, 1)
    }
        
    func testTableWillLoadMoreDataOnScroll() {
        var mockTestData = StarLordDataModel()
        mockTestData.title = "hackerearth"
        mockTestData.blurb = "hackerearth blurb"
        var mockArray = [StarLordDataModel]()
        mockArray.append(mockTestData)
        mockArray = Array(repeating: mockArray[0], count: 20)
        viewController?.dataList = mockArray
        mockArray = Array(repeating: mockArray[0], count: 80)
        viewController?.masterDataList = mockArray
        let lastIndex = IndexPath(row: 19, section: 0)
        let cell = (viewController?.tableView(viewController!.starLordListTableview, cellForRowAt: lastIndex))!
        
        viewController?.tableView(viewController!.starLordListTableview, willDisplay: cell, forRowAt: lastIndex)
        
        XCTAssertEqual(viewController?.dataList.count, 40)
    }
    
}

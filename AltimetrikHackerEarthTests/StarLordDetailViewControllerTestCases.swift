//
//  StarLordDetailViewControllerTestCases.swift
//  AltimetrikHackerEarthTests
//
//  Created by Soumya, Singh on 27/04/20.
//  Copyright © 2020 Soumya, Singh. All rights reserved.
//

import XCTest
@testable import AltimetrikHackerEarth

class StarLordDetailViewControllerTestCases: XCTestCase {
    var viewController : StarlordDetailViewController?
    
    override func setUp() {
        viewController = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryBoardKeys.STARLORD_DETAIL.rawValue) as! StarlordDetailViewController)
        
        viewController!.loadView()
    }

    override func tearDown() {
        viewController = nil
    }

    func testUIisUpdatedBasedOndataReceived() {
        
        let mockTestData = getMockdata()
        viewController?.dataModel = mockTestData
        
        viewController?.viewDidLoad()
        
        XCTAssertEqual(viewController?.titleLabel.text, mockTestData.title)
        XCTAssertEqual(viewController?.descriptionLbl.text, mockTestData.blurb)
        XCTAssertEqual(viewController?.countrylbl.text, mockTestData.country)
        XCTAssertEqual(viewController?.locationlbl.text, mockTestData.location)
        XCTAssertEqual(viewController?.byLabel.text, mockTestData.by)
        XCTAssertEqual(viewController?.noOfBackerslbl.text, mockTestData.numBackers)
        XCTAssertEqual(viewController?.amountLbl.text, "\(mockTestData.amtPledged ?? 0)")
    }
    
    func getMockdata() -> StarLordDataModel {
        var mockTestData = StarLordDataModel()
        mockTestData.title = "hackerearth"
        mockTestData.blurb = "hackerearth blurb"
        mockTestData.country = "US"
        mockTestData.location = "Chicago"
        mockTestData.amtPledged = 1000
        mockTestData.by = "Tester"
        mockTestData.numBackers = "10"
        return mockTestData
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

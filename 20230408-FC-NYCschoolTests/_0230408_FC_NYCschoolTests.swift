//
//  _0230408_FC_NYCschoolTests.swift
//  20230408-FC-NYCschoolTests
//
//  Created by FredyCamas on 4/8/23.
//

import XCTest
@testable import _0230408_FC_NYCschool

final class _0230408_FC_NYCschoolTests: XCTestCase {

    var viewModel: SchoolViewModel!
        
        override func setUpWithError() throws {
            viewModel = SchoolViewModel()
        }
        
        override func tearDownWithError() throws {
            viewModel = nil
        }
        
    func testFetchSchoolData() {
           let expectation = XCTestExpectation(description: "Fetch School Data")
           viewModel.fetchSchoolData()
           DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // wait for 3 seconds for the data to be fetched
               XCTAssertGreaterThan(self.viewModel.mainCardContainerSchool.count, 0)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 5.0)
       }
       
       func testFetchSatData() {
           let expectation = XCTestExpectation(description: "Fetch SAT Data")
           viewModel.fetchSatData(newCard: "01M292")
           DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // wait for 3 seconds for the data to be fetched
               XCTAssertNotNil(self.viewModel.disSat)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 5.0)
       }
       
       
       func testOnSearch() {
           let search = "Test Search"
           viewModel.onSearch(search)
           XCTAssertEqual(viewModel.model.search, search)
       }
       
       func testSearch() {
           viewModel.mainCardContainerSchool = [SchoolModel.SchoolCard(name: "Test School A"),
                                                SchoolModel.SchoolCard(name: "Test School B"),
                                                SchoolModel.SchoolCard(name: "Another Test School")]
           viewModel.search(searchText: "test school")
           XCTAssertEqual(viewModel.disSchool.count, 3)
       }

}

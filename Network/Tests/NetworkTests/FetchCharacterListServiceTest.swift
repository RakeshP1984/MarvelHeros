//
//  FetchCharacterListServiceTest.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import XCTest
@testable import Network

class FetchCharacterListServiceTest: XCTestCase {
    var fetchCharacterListService = FetchCharacterListService(serviceProvider: MarvelAPIMockServiceProvider())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testListCharactersRequest() {
        let expectation = XCTestExpectation(description: "List Characters")
        fetchCharacterListService.fetchList(name: "", limit: 20, offset: 0) { result in
            switch result {
            case .success(let pageData):
                XCTAssertTrue(pageData.offset == 0)
                let items = pageData.listItem
                XCTAssertTrue(items.count == pageData.total)

            case .failure(let failuer):
                XCTFail(failuer.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testSearchCharactersRequest() {
        let expectation = XCTestExpectation(description: "List Characters")
        fetchCharacterListService.fetchList(name: "Iron Man", limit: 20, offset: 0) { result in
            switch result {
            case .success(let pageData):
                XCTAssertTrue(pageData.offset == 0)
                let items = pageData.listItem
                XCTAssertTrue(items.count == 1)

            case .failure(let failuer):
                XCTFail(failuer.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

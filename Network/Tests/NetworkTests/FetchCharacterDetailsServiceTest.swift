//
//  FetchCharacterDetailsService.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import XCTest
import Domain
@testable import Network

final class MockTask: Task {
    func cancel() {}
    func suspend() {}
    func resume() {}
}

class MarvelAPIMockServiceProvider: ServiceProvider {
    func GET<T>(endPoint: Endpoint,
                params: [String: String]?,
                completionHandler: @escaping (Result<T, APIError>) -> Void) -> Task where T: Decodable {
        DispatchQueue.main.async {
            let item1 = Item(resourceURI: "", name: "String 1")

            lazy var otherDetails = OtherItems(available: 1, items: [item1])
            lazy var character1 = Character(id: 1, name: "Iron Man",
                                            description: "",
                                            thumbnail: nil,
                                            comics: otherDetails,
                                            series: otherDetails,
                                            stories: otherDetails,
                                            events: otherDetails)
            lazy var pageInfo = PageData(offset: 0, limit: 20, total: 1, count: 1, results: [character1])
            lazy var apiResponse = APIResponse(code: 1, status: "200", data: pageInfo)
            return completionHandler(.success(apiResponse as! T))
        }
        return MockTask()
    }
}

class FetchCharacterDetailsServiceTest: XCTestCase {
    var fetchCharacterDetailsService = FetchCharacterDetailsService(serviceProvider: MarvelAPIMockServiceProvider())

    func testFetchDetails() {
        let expectation = XCTestExpectation(description: "Fetch Character Pass Expection!!")
        fetchCharacterDetailsService.fetchDetails(id: 1) { result in
            switch result {
            case .success(let character):
                XCTAssertEqual(character.Id, 1)
                XCTAssertEqual(character.series.heading, "Series")
                XCTAssertEqual(character.comics.heading, "Comics")
                XCTAssertEqual(character.events.heading, "Events")
                XCTAssertEqual(character.stories.heading, "Stories")

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

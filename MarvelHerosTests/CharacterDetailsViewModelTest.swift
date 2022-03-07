//
//  CharacterDetailsViewModelTest.swift
//  MarvelHerosTests
//
//  Created by Rakesh Patole on 02/03/22.
//

import XCTest
import DependencyManager
import Network
import Domain
@testable import MarvelHeros

final class FetchCharacterDetailsServiceMock: FetchItemDetailsService {
    lazy var mockDataProvider = MockDataProvider()

    func fetchDetails(id: Int,
                      completionHandler: @escaping (Result<CharacterDetailsDTO, FetchItemDetailsServiceError>) -> Void) -> Task {
        DispatchQueue.main.async {
            let result = self.mockDataProvider.dataWith(id: id)
            completionHandler(result)
        }
        return MockTask()
    }
}

class CharacterDetailsViewModelTest: XCTestCase {
    var viewModel: CharacterDetailsViewModel!
    
    override func setUpWithError() throws {
        DependencyManager.manager.addDependency(dependency:FetchCharacterDetailsServiceMock() as FetchItemDetailsService?)
        let character = ListItemDTO(id: 1, heading: "", body: "", thumbnailImageURL: nil)
        viewModel = CharacterDetailsViewModel(character: character)
    }
    
    func testLoadDetails() {
        let loadExpection = XCTestExpectation(description: "View Model Load Character Details Expectation")
        viewModel.loadDetails()
        viewModel.eventListner = { event in            
            switch event {
            case .didLoadCharacter(let result):
                switch result {
                case .success(let character):
                    XCTAssertEqual(character.Id, 1)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
            loadExpection.fulfill()
        }
        wait(for: [loadExpection], timeout: 10)
    }
}

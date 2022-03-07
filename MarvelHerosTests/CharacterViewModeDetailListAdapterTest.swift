//
//  CharacterViewModeDetailListAdapterTest.swift
//  MarvelHerosTests
//
//  Created by Rakesh Patole on 02/03/22.
//

import Foundation
import XCTest
import Network
import Domain
import DependencyManager
@testable import MarvelHeros

class CharacterViewModeDetailListAdapterTest: XCTestCase {
    var characterViewModeDetailListAdapter: CharacterViewModeDetailListAdapter!
    var viewModel: CharacterDetailsViewModel!

    override func setUpWithError() throws {
        DependencyManager.manager.addDependency(dependency:FetchCharacterDetailsServiceMock() as FetchItemDetailsService?)
        let character = ListItemDTO(id: 1, heading: "", body: "", thumbnailImageURL: nil)
        viewModel = CharacterDetailsViewModel(character: character)
        characterViewModeDetailListAdapter = CharacterViewModeDetailListAdapter(viewModel: viewModel)
    }
    
    func testLoadNext() {
        let loadExpection = XCTestExpectation(description: "View Model Load Character Details Expectation")
        characterViewModeDetailListAdapter.loadFirst()
        characterViewModeDetailListAdapter.listUpdateListener = { [weak self] event in
            guard let adpater = self?.characterViewModeDetailListAdapter else { return }
            switch event {
            case .didLoadPage:
                XCTAssertEqual(adpater.numberOfSections(), 5)
                XCTAssertEqual(adpater.numberOfListItems(inSection: 0), 1)
                XCTAssertEqual(adpater.numberOfListItems(inSection: 1), 1)
                XCTAssertEqual(adpater.numberOfListItems(inSection: 2), 1)
                XCTAssertEqual(adpater.numberOfListItems(inSection: 3), 1)
                XCTAssertEqual(adpater.numberOfListItems(inSection: 4), 1)

            case .pageLoadError(let error):
                XCTFail(error.localizedDescription)

            default: ()
            }
            loadExpection.fulfill()
        }
        wait(for: [loadExpection], timeout: 10)
    }
}

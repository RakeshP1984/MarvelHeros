//
//  CharacterDetailsViewModelTest.swift
//  MarvelHerosTests
//
//  Created by Rakesh Patole on 02/03/22.
//

import XCTest
import DependencyManager
import Domain
@testable import MarvelHeros

final class MockTask: Task {
    func resume() {}
    func suspend() {}
    func cancel() {}
}

final class MockDataProvider {
    let listItem1 = ListItemDTO(id: 1, heading: "Iron Man", body: "", thumbnailImageURL: nil)
    let listItem2 = ListItemDTO(id: 2, heading: "Captain America", body: "", thumbnailImageURL: nil)
    let listItem3 = ListItemDTO(id: 3, heading: "Spider Man", body: "", thumbnailImageURL: nil)
    lazy var allItems =  [listItem1, listItem2, listItem3]

    func dataWith( name: String, limit: Int, offset: Int ) -> Result<ListPageDTO,ListFetchErrors> {
        var items = allItems
        if name.count > 0 {
            items = allItems.filter { $0.heading == name }
        }
        var result: Result<ListPageDTO,ListFetchErrors>
        if items.count == 0 {
            result = .failure(.noCharactersFound)
        } else {
            let listPage  = ListPageDTO(pageNo: 1, offset: 0, total: items.count, listItem:items)
            result = .success(listPage)
        }
        return result
    }

    func dataWith( id: Int) -> Result<CharacterDetailsDTO,FetchItemDetailsServiceError> {
        var result: Result<CharacterDetailsDTO,FetchItemDetailsServiceError>
        if id != 1 {
            result = .failure(.noItemFound)
        } else {
            let character = CharacterDetailsDTO(Id: 1,
                                                headerDetails: ListItemDTO(id: 0, heading: "Iron Man", body: "Nothing", thumbnailImageURL: nil),
                                                stories: CharacterOtherDetailsDTO(heading: "Stories", body: ""),
                                                comics: CharacterOtherDetailsDTO(heading: "Comics", body: ""),
                                                events: CharacterOtherDetailsDTO(heading: "Events", body: ""),
                                                series: CharacterOtherDetailsDTO(heading: "Series", body: ""),
                                                thumbnailImageURL: nil)
            result = .success(character)
        }
        return result
    }
}

final class FetchListServiceMock: FetchListService {
    lazy var mockDataProvider = MockDataProvider()
    func fetchList(name: String,
                   limit: Int,
                   offset: Int,
                   completionHandler: @escaping (Result<ListPageDTO, ListFetchErrors>) -> Void) -> Task {
        DispatchQueue.main.async {
            let result = self.mockDataProvider.dataWith(name: name, limit: limit, offset: offset)
            completionHandler(result)
        }
        return MockTask()
    }
}

class CharacterListViewModelTest: XCTestCase {
    var viewModel: CharacterViewModel!
    override func setUpWithError() throws {
        DependencyManager.manager.addDependency(dependency:FetchListServiceMock() as FetchListService?)
        viewModel = CharacterViewModel()
    }
    
    func testLoadPage() {
        let loadExpection = XCTestExpectation(description: "View Model Load Page Character Expectation")
        viewModel.load()
        viewModel.eventListener = { [weak self] event in
            guard let viewModel = self?.viewModel else {
                loadExpection.fulfill()
                return
            }
            
            switch event {
            case .didLoadPage:
                XCTAssertEqual(viewModel.pageInfo?.offset, 0)
                XCTAssertEqual(viewModel.characters.count, viewModel.pageInfo?.total)
                
            case .pageLoadFail(let error):
                XCTFail(error.localizedDescription)

            default: ()
            }
            loadExpection.fulfill()
        }
        wait(for: [loadExpection], timeout: 3)
    }
    
    func testSearch() {
        let expectation = XCTestExpectation(description: "View Model Search Character Expectation")
        viewModel.searchQuery = "Iron Man"
        viewModel.eventListener = { [weak self] event in
            guard let self = self else {
                expectation.fulfill()
                return
            }
            
            switch event {
            case .didLoadPage:
                XCTAssertEqual(self.viewModel.searchQuery, "Iron Man")
                XCTAssertEqual(self.viewModel.characters.count, 1)
                XCTAssertEqual(self.viewModel.characters.first?.heading, "Iron Man")

            case .pageLoadFail(let error):
                XCTFail(error.localizedDescription)

            case .isLoading:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testFailSearch() {
        let expectation = XCTestExpectation(description: "View Model Search Character Expectation")
        viewModel.searchQuery = "Iron"
        viewModel.eventListener = { event in
            switch event {
            case .didLoadPage:
                XCTFail("Character should not be found!!")

            case .pageLoadFail(let error):
                XCTAssertEqual( error as? ListFetchErrors, ListFetchErrors.noCharactersFound)

            case .isLoading:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}

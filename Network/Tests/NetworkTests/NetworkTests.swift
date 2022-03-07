import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    let marvelAPIService: MarvelAPIService = MarvelAPIService.shared
    func testSearchCharacterEndPoint() {
        let searchEndPoint = Endpoint.searchCharacter(name: "Iron Man", limit: nil, offset: nil)
        let params = searchEndPoint.params()
        XCTAssertEqual(params?.count, 1)
        XCTAssertEqual(params, ["name": "Iron Man"])
        let path = searchEndPoint.path()
        XCTAssertEqual(path, "/characters")
    }

    func testListCharactersEndPoint() {
        let searchEndPoint = Endpoint.searchCharacter(name: "", limit: 20, offset: 0)
        let params = searchEndPoint.params()
        XCTAssertEqual(params?.count, 2)
        XCTAssertEqual(params, ["limit": "20", "offset": "0"])
        let path = searchEndPoint.path()
        XCTAssertEqual(path, "/characters")
    }

    func testGetCharacterDetailsEndPoint() {
        let character = Character(id: 12,
                                  name: nil,
                                  description: nil,
                                  thumbnail: nil,
                                  comics: nil,
                                  series: nil,
                                  stories: nil,
                                  events: nil)
        let characterDetails = Endpoint.getCharacterDetails(character: character)
        let params = characterDetails.params()
        XCTAssertEqual(params?.count, nil)
        let path = characterDetails.path()
        XCTAssertEqual(path, "/characters/12")
    }
}

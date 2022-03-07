import XCTest
@testable import DependencyManager

final class MockDependency1: Equatable {
    let id: Int

    init(_ id: Int) {
        self.id = id
    }

    static func == (lhs: MockDependency1, rhs: MockDependency1) -> Bool {
        return lhs.id == rhs.id
    }
}

final class MockDependency2: Equatable {
    let id: Int

    init(_ id: Int) {
        self.id = id
    }

    static func == (lhs: MockDependency2, rhs: MockDependency2) -> Bool {
        return lhs.id == rhs.id
    }
}

final class DependencyManagerTests: XCTestCase {
    private let dependencyManager: DependencyManager = DependencyManager.manager

    func test_add_resolve_found() throws {
        let dependency: MockDependency1 = MockDependency1(1)
        dependencyManager.addDependency(dependency: dependency as MockDependency1?)
        let resolvedDependency: MockDependency1? = try dependencyManager.resolve()
        XCTAssertEqual(dependency, resolvedDependency)
    }

    func test_add_resolve_dependencyNotFound() throws {
        do {
            let dependency: MockDependency1 = MockDependency1(1)
            dependencyManager.addDependency(dependency: dependency as MockDependency1?)
            let _: MockDependency2 = try dependencyManager.resolve()
            XCTFail("MockDependency not added hence cannot be returned!!")
        } catch {
            XCTAssertEqual(error as? DependencyManagerError,
                           DependencyManagerError.dependencyNotFound("MockDependency2"))
        }
    }
}

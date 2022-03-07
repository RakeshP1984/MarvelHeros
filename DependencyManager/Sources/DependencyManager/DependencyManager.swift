//
//  File.swift
//
//
//  Created by Rakesh Patole on 26/02/22.
//

@propertyWrapper public struct Dependency<T> {
    public var wrappedValue: T?
    public init() {
        self.wrappedValue = try? DependencyManager.manager.resolve()
    }
}

enum DependencyManagerError: Error, Equatable {
    case dependencyNotFound(String)
}

public final class DependencyManager {
    private var dependencies: [String: AnyObject] = [String: AnyObject]()
    public static let manager = DependencyManager()

    private func key<T>( _ dependencyType: T.Type) -> String {
        return String(describing: T.self)
    }

    public func addDependency<T>(dependency: T) {
        let key = key(type(of: dependency))
        dependencies[key] = dependency as AnyObject
    }

    public func resolve<T>() throws -> T {
        let key = key(T.self)
        guard let returnDependency = dependencies[key] as? T else {
            throw DependencyManagerError.dependencyNotFound(key)
        }
        return returnDependency
    }
}

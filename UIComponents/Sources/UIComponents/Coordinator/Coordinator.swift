//
//  File.swift
//  
//
//  Created by Rakesh Patole on 27/02/22.
//

import Foundation
import UIKit

open class Coordinator: NSObject {
    public var parentCoordinator: Coordinator?
    public lazy var childCoordinators: [Coordinator] = [Coordinator]()
    public var viewController: UIViewController!
    open func start() {}

    public override init() {}

    open func removeFromParentCoordinator() {
        self.parentCoordinator?.removeChildCoordinator(coordinator: self)
    }

    open func addChildCoordinator(coordinator: Coordinator, animated: Bool = false) {
        coordinator.removeFromParentCoordinator()
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }

    @discardableResult
    open func removeChildCoordinator(coordinator: Coordinator, animated: Bool = false ) -> Coordinator? {
        if let index = self.childCoordinators.firstIndex(where: { coordinator === $0 }) {
            self.childCoordinators.remove(at: index)
            coordinator.parentCoordinator = nil
            return coordinator
        }
        return nil
    }

    final public func navigationCoordinator() -> NavigationCoordinator? {
        if let navigationCoordinator = self as? NavigationCoordinator {
            return navigationCoordinator
        } else {
            return parentCoordinator?.navigationCoordinator()
        }
    }
}

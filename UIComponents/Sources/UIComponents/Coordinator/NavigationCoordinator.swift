//
//  File.swift
//  
//
//  Created by Rakesh Patole on 27/02/22.
//

import Foundation
import UIKit

open class NavigationCoordinator: Coordinator, UINavigationControllerDelegate {
    public var rootCoordinator: Coordinator

    public init(rootCoordinator: Coordinator) {
        self.rootCoordinator = rootCoordinator
        super.init()
        self.viewController = UINavigationController(rootViewController: rootCoordinator.viewController)
        self.viewController.view.insetsLayoutMarginsFromSafeArea = true
        self.addChildCoordinator(coordinator: rootCoordinator)
    }

    public var navigationController: UINavigationController? {
        get { return viewController as? UINavigationController }
        set { self.viewController = newValue }
    }

    open func pushCoordinator( coordinator: Coordinator, animated: Bool = false) {
        self.addChildCoordinator(coordinator: coordinator)
        self.navigationController?.pushViewController(coordinator.viewController, animated: animated)
    }

    open func popCoordinator( coordinator: Coordinator, animated: Bool = false) {
        if let coordinator = self.removeChildCoordinator(coordinator: coordinator) {
            coordinator.viewController.navigationController?.popViewController(animated: animated)
        }
    }
}

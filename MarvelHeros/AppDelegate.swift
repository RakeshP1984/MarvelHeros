//
//  AppDelegate.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 25/02/22.
//

import UIKit
import UIComponents
import DependencyManager
import Network
import Domain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let apiService = MarvelAPIService.shared
        let fetchListService = FetchCharacterListService(serviceProvider: apiService)
        let fetchDetailService = FetchCharacterDetailsService(serviceProvider: apiService)
        DependencyManager.manager.addDependency(dependency: fetchListService as FetchListService?)
        DependencyManager.manager.addDependency(dependency: fetchDetailService as FetchItemDetailsService?)
        coordinator = MainCoordinator()
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = coordinator?.viewController
        window?.makeKeyAndVisible()
        return true
    }
}

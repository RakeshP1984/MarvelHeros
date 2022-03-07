//
//  MainCoordinator.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation
import UIComponents

final class MainCoordinator: NavigationCoordinator {
    init() {
        super.init(rootCoordinator: CharacterListViewCoordinator())
    }
}

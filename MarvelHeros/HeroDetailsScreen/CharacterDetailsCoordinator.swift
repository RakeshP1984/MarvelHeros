//
//  HeroDetailsCordinator.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 27/02/22.
//

import Foundation
import UIComponents
import UIKit
import Domain

final class CharacterDetailsCoordinator: Coordinator, ListViewCoordinator {
    public var character: ListItemDTO
    init(character: ListItemDTO) {
        self.character = character
        super.init()
        self.viewController = MarvelViewControllerFactory.marvelHeroDetailsViewController(coordinator: self)
    }

    func showError(_ error: Error) {
        let alert = UIAlertController(title: StringContants.Alert,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: StringContants.Cancel, style: .cancel) { _ in
            self.viewController.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        self.viewController.present(alert, animated: true, completion: nil)
    }
}

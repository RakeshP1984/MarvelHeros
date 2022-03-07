//
//  MarvelHeroListCoordinator.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 27/02/22.
//

import Foundation
import UIComponents
import Domain
import UIKit

final class CharacterListViewCoordinator: Coordinator, ListViewCoordinator {
    var vStackViewController: StackViewController? {
        get { return self.viewController as? StackViewController }
        set { self.viewController = newValue }
    }

    override init() {
        super.init()
        self.viewController = MarvelViewControllerFactory.marvelHeroListViewController(coordinator: self)
    }

    func showDetails(of item: ViewObject) {
        guard let character = item as? ListItemDTO else { return }
        let heroDetailsCoordinator = CharacterDetailsCoordinator(character: character)
        self.navigationCoordinator()?.pushCoordinator(coordinator: heroDetailsCoordinator, animated: true)
    }

    func showError(_ error: Error) {
        let alert = UIAlertController(title: StringContants.Alert,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringContants.Cancel, style: .cancel, handler: nil))
        self.viewController.present(alert, animated: true, completion: nil)
    }
}

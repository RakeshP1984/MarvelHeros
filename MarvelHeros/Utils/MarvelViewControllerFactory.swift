//
//  MarvelViewControllerFactory.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 27/02/22.
//

import Foundation
import UIComponents
import DependencyManager
import UIKit

final class MarvelViewControllerFactory {
    class func marvelHeroListViewController(coordinator: ListViewCoordinator) -> StackViewController {
        let sectionHandlers: [SectionHandler] = [CharacterDetailTableViewSectionHandler()]
        let sectionContainer = SectionContainer(sectionHandlers: sectionHandlers)
        let viewModel: CharacterViewModel = CharacterViewModel()
        let tableViewController = TableViewController(viewModel: CharacterViewModelListAdapter(viewModel: viewModel),
                                                      coordinator: coordinator,
                                                      sectionContainer: sectionContainer)
        let characterViewModelSearchAdapter = CharacterViewModelSearchAdapter(viewModel: viewModel)
        let searchViewController = SearchViewController(style: .minimal,
                                                        viewModel: characterViewModelSearchAdapter)
        let stackViewController = StackViewController([searchViewController, tableViewController])
        stackViewController.title = StringContants.CharacterListScreenTitle
        return stackViewController
    }

    class func marvelHeroDetailsViewController(coordinator: CharacterDetailsCoordinator) -> TableViewController {
        let detailSectionHandler = CharacterDetailTableViewSectionHandler()
        let otherDetailsSectionHandler = CharacterOtherDetailsSectionHandler()
        let sectionHandlers: [SectionHandler] = [detailSectionHandler, otherDetailsSectionHandler]
        let sectionContainer = SectionContainer(sectionHandlers: sectionHandlers)
        let viewModel = CharacterDetailsViewModel(character: coordinator.character)
        let viewModelAdapter = CharacterViewModeDetailListAdapter(viewModel: viewModel)
        let tableViewController = TableViewController(viewModel: viewModelAdapter,
                                                      coordinator: coordinator,
                                                      sectionContainer: sectionContainer)
        tableViewController.title = coordinator.character.heading
        return tableViewController
    }
}

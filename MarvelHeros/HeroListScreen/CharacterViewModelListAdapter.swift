//
//  CharacterViewModelListAdapter.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 02/03/22.
//

import Foundation
import UIComponents

final class CharacterViewModelListAdapter: ListViewModel {
    var listUpdateListener: ListUpdateListener?
    let viewModel: CharacterViewModel

    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        self.viewModel.eventListener = { [weak self] event in
            self?.eventUpdateListner(event: event)
        }
    }

    func eventUpdateListner(event: CharacterViewModelEvents) {
        switch event {
        case .didLoadPage:
            self.listUpdateListener?(.didLoadPage)

        case .pageLoadFail(let error):
            self.listUpdateListener?(.pageLoadError(error))

        case .isLoading(let isLoading):
            self.listUpdateListener?(.isLoading(isLoading))
        }
    }

    func numberOfSections() -> Int { 1 }

    func numberOfListItems(inSection section: Int) -> Int {
        viewModel.characters.count
    }

    func listItem(atIndexPath indexPath: IndexPath) -> ViewObject {
        viewModel.characters[indexPath.row]
    }

    func loadFirst() { viewModel.load() }
    func loadNext() { viewModel.loadNext() }
}

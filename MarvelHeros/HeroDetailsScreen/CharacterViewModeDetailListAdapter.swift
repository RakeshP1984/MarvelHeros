//
//  CharacterViewModeDetailListAdapter.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 02/03/22.
//

import Foundation
import UIComponents
import Domain

private enum CharacterDetailSections: Int {
    case detail
    case comics
    case series
    case stories
    case events
}

private class CharacterSectionHelper {
    fileprivate var character: CharacterDetailsDTO?

    func itemList(inSection section: Int ) -> ViewObject {
        guard let section = CharacterDetailSections.init(rawValue: section),
              let character = character else { return ListItemDTO(id: 0, heading: "", body: "") }
        switch section {
        case .detail: return character.headerDetails
        case .comics: return character.comics
        case .series: return character.series
        case .stories: return character.stories
        case .events: return character.events
        }
    }

    func numberOfSections() -> Int {
        guard character != nil else { return 0 }
        return 5
    }

    func numberOfListItems(inSection section: Int) -> Int {
        guard character != nil else { return 0 }
        return 1
    }

    func listItem(atIndexPath indexPath: IndexPath) -> ViewObject {
        let items = self.itemList(inSection: indexPath.section)
        return items
    }
}

class CharacterViewModeDetailListAdapter: ListViewModel {
    var listUpdateListener: ListUpdateListener?
    private var viewModel: CharacterDetailsViewModel
    private var characteSectionHelper: CharacterSectionHelper

    init( viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        self.characteSectionHelper = CharacterSectionHelper()
        self.viewModel.eventListner = { [weak self] event in
            self?.eventListner(event: event)
        }
    }

    func eventListner(event: CharacterDetailsEvent) {
        switch event {
        case .didLoadCharacter(let result):
            switch result {
            case .success(let character):
                self.characteSectionHelper.character = character
                self.listUpdateListener?(.didLoadPage)

            case .failure:
                self.characteSectionHelper.character = nil
            }
        }
    }

    func numberOfSections() -> Int {
        characteSectionHelper.numberOfSections()
    }

    func numberOfListItems(inSection section: Int) -> Int {
        characteSectionHelper.numberOfListItems(inSection: section)
    }

    func listItem(atIndexPath indexPath: IndexPath) -> ViewObject {
        characteSectionHelper.listItem(atIndexPath: indexPath)
    }

    func loadFirst() {
        viewModel.loadDetails()
    }

    func loadNext() {}
}

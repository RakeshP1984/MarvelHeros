//
//  MarvelHeroListViewModel.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import DependencyManager
import Domain

enum CharacterViewModelEvents {
    case didLoadPage
    case isLoading(Bool)
    case pageLoadFail(Error)
}

typealias CharacterViewModelUpdateEventsListener = (CharacterViewModelEvents) -> Void

final class CharacterViewModel {
    var characters: [ListItemDTO]
    var pageInfo: ListPageDTO?
    var limit: Int = 20
    var isLoading: Bool { fetchListTask != nil }
    var eventListener: CharacterViewModelUpdateEventsListener?
    var fetchListTask: Task?

    var searchQuery: String = "" {
        didSet {
            self.pageInfo = nil
            self.load()
        }
    }

    @Dependency var fetchListService: FetchListService?

    init() {
        self.characters = [ListItemDTO]()
    }

    public func load() {
        let offset = pageInfo.map { $0.offset + limit } ?? 0
        fetchListTask?.cancel()
        fetchListTask = fetchListService?.fetchList(name: searchQuery,
                                                    limit: limit,
                                                    offset: offset ) { [weak self] (result: Result<ListPageDTO, ListFetchErrors>) in
            guard let self = self else { return }
            self.eventListener?(.isLoading(false))
            self.fetchListTask = nil
            switch result {
            case .success(let response):
                let items = response.listItem
                self.pageInfo = response
                if self.pageInfo?.offset == 0 {
                    self.characters = items
                } else {
                    self.characters.append(contentsOf: items)
                }

                self.eventListener?(.didLoadPage)

            case .failure(let failure):
                self.eventListener?(.pageLoadFail(failure))
            }
        }
        self.eventListener?(.isLoading(true))
    }

    func loadNext() {
        if pageInfo?.total ?? 0 > characters.count {
            load()
        }
    }
}

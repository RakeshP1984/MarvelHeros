//
//  MarvelHeroDetailsViewModel.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 28/02/22.
//

import Foundation
import Domain
import DependencyManager

enum CharacterViewModelError: Error {
    case noCharacterFound
    case otherError(Error)
}

enum CharacterDetailsEvent {
    case didLoadCharacter(Result<CharacterDetailsDTO, CharacterViewModelError>)
}

typealias CharacterDetailsViewModelEventsListner = (CharacterDetailsEvent) -> Void

final class CharacterDetailsViewModel {
    var item: ListItemDTO
    var eventListner: CharacterDetailsViewModelEventsListner?
    @Dependency var fetchDetailService: FetchItemDetailsService?

    init( character: ListItemDTO) {
        self.item = character
    }

    func loadDetails() {
        self.fetchDetailService?.fetchDetails(id: item.id) { [weak self] result in
            guard let eventListner = self?.eventListner else { return }
            switch result {
            case .success(let item):
                eventListner(.didLoadCharacter(.success(item)))
            case .failure(let error):
                eventListner(.didLoadCharacter(.failure(.otherError(error))))
            }
        }
    }
}

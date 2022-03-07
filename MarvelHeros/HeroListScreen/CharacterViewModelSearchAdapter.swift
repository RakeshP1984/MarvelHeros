//
//  CharacterViewModelSearchAdapter.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 02/03/22.
//

import Foundation
import UIComponents

final class CharacterViewModelSearchAdapter: SearchViewModel {
    var searchQuery: String {
        get { viewModel.searchQuery }
        set { viewModel.searchQuery = newValue }
    }

    let viewModel: CharacterViewModel

    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
    }
}

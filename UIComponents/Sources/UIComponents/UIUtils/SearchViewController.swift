//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import UIKit

public protocol SearchViewModel {
    var searchQuery: String { get set }
}

public class SearchViewController: UIViewController, HasViewModel {
    public var viewModel: SearchViewModel
    private var searchFireTimer: Timer?
    private lazy var searchBar: UISearchBar = {
        $0.delegate = self
        return $0
    }(UISearchBar())

    public init( style: UISearchBar.Style = .default, viewModel: SearchViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        searchBar.searchBarStyle = style
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        self.view = searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }

    private func cancelSearchFireTimer() {
        if let timer = searchFireTimer, timer.isValid {
            timer.invalidate()
        }
    }

    deinit {
        cancelSearchFireTimer()
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cancelSearchFireTimer()
        searchFireTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false ) { [weak self] _ in
            self?.viewModel.searchQuery = searchText
        }
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

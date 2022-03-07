//
//  File.swift
//  
//
//  Created by Rakesh Patole on 02/03/22.
//

import Foundation

public enum ListUpdateEvent {
    case didLoadPage
    case isLoading(Bool)
    case pageLoadError(Error)
}

public typealias ListUpdateListener = (ListUpdateEvent) -> Void

public protocol ListViewModel {
    var listUpdateListener: ListUpdateListener? { get set }
    func numberOfSections() -> Int
    func numberOfListItems( inSection section: Int) -> Int
    func listItem( atIndexPath indexPath: IndexPath) -> ViewObject
    func loadFirst()
    func loadNext()
}

extension ListViewModel {
    public func loadFirst() {}
    public func loadNext() {}
}

public protocol ListViewCoordinator: Coordinator {
    func showDetails(of item: ViewObject)
    func showError(_ error :Error)
}

extension ListViewCoordinator {
    public func showDetails(of item: ViewObject) {}
}

public protocol ListViewController: HasViewModel {
    var viewModel: ListViewModel { get }
    var coordinator: ListViewCoordinator? { get }
    var sectionContainer: SectionContainer { get }
}

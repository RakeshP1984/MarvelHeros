//
//  File.swift
//  
//
//  Created by Rakesh Patole on 25/02/22.
//

import Foundation
import UIKit

public class TableViewController: UIViewController, ListViewController, UITableViewDelegate, UITableViewDataSource {
    public var viewModel: ListViewModel
    public weak var coordinator: ListViewCoordinator?
    public var sectionContainer: SectionContainer
    public lazy var activityIndicator: UIActivityIndicatorView = {
        $0.style = .medium
        $0.isHidden = true
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView())

    public lazy var tableView: UITableView = {
        $0.rowHeight = UITableView.automaticDimension
        $0.dataSource = self
        $0.delegate = self
        $0.keyboardDismissMode = .onDrag
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    public init( viewModel: ListViewModel,
                 coordinator: ListViewCoordinator? = nil,
                 sectionContainer: SectionContainer ) {
        self.sectionContainer = sectionContainer
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.viewModel.listUpdateListener = { [weak self] event in
            self?.updateEventListener(event: event)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        self.sectionContainer.registerCell(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadFirst()
    }

    private func updateEventListener(event: ListUpdateEvent) {
        switch event {
        case .didLoadPage:
            tableView.reloadData()

        case .pageLoadError(let error):
            coordinator?.showError(error)

        case .isLoading(let isLoading):
            isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
}

extension TableViewController {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.listItem(atIndexPath: indexPath)
        self.coordinator?.showDetails(of: item)
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfListItems(inSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listItem = viewModel.listItem(atIndexPath: indexPath)
        let cell: UITableViewCell? = self.sectionContainer.dequeueView(tableView,
                                                                       cellForListItem: listItem,
                                                                       atIndexPath: indexPath) as? UITableViewCell
        return cell ?? UITableViewCell()
    }

    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView,
                          willDisplay cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.numberOfListItems(inSection: indexPath.section) - 1) {
            viewModel.loadNext()
        }
    }
}

//
//  File.swift
//  
//
//  Created by Rakesh Patole on 28/02/22.
//

import Foundation
import UIKit

public class CollectionViewController: UICollectionViewController, ListViewController {
    public var viewModel: ListViewModel
    public var coordinator: ListViewCoordinator?
    public var sectionContainer: SectionContainer

    public init( layout: UICollectionViewLayout,
                 viewModel: ListViewModel,
                 coordinator: ListViewCoordinator? = nil,
                 sectionContainer: SectionContainer) {
        self.sectionContainer = sectionContainer
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        sectionContainer.registerCell(collectionView)
    }
}

extension CollectionViewController {
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }

    public override func collectionView(_ collectionView: UICollectionView,
                                        numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfListItems(inSection: section)
    }

    public override func collectionView(_ collectionView: UICollectionView,
                                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listItem = viewModel.listItem(atIndexPath: indexPath)
        let cell: UICollectionViewCell? = sectionContainer.dequeueView(collectionView,
                                                                      cellForListItem: listItem,
                                                                      atIndexPath: indexPath) as? UICollectionViewCell
        return cell ?? UICollectionViewCell()
    }

    public override func collectionView(_ collectionView: UICollectionView,
                                        didSelectItemAt indexPath: IndexPath) {
    }
}

//
//  HeroDetailsSectionHandler.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 28/02/22.
//

import Foundation
import UIComponents
import UIKit
import Domain

final class CharacterOtherDetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var headingLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!

    func updateView(_ viewObject: ViewObject) {
        headingLabel.text = viewObject.heading
        bodyLabel.text = viewObject.body
    }
}

final class CharacterOtherDetailsSectionHandler: SectionHandler {
    var listItemTypes: [ViewObject.Type] { [CharacterOtherDetailsDTO.self] }
    func registerCell(_ viewRecycler: ViewRecycler) {
        viewRecycler.registerNib(recyclableView: CharacterOtherDetailsTableViewCell.self, bundle: nil)
    }

    func dequeueView(_ viewRecycler: ViewRecycler,
                     cellForListItem item: ViewObject,
                     atIndexPath indexPath: IndexPath) -> Recyclable {
        let cellType = CharacterOtherDetailsTableViewCell.self
        let cell: CharacterOtherDetailsTableViewCell = viewRecycler.dequeueView(recyclableView: cellType,
                                                                                for: indexPath)!
        cell.updateView(item)
        return cell
    }
}

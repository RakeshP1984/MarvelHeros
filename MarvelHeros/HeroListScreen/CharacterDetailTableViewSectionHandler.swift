//
//  HeroListSectionHandler.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 24/02/22.
//

import Foundation
import UIComponents
import UIKit
import Domain

final class CharacterDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var profileImageView: AsyncImageView!
    @IBOutlet private weak var nameLableBackgroundView: UIView!

    override func awakeFromNib() {
        profileImageView.layer.cornerRadius = 10
        nameLableBackgroundView.layer.cornerRadius = 10
        nameLableBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        imageView?.image = nil
    }

    func update(_ viewObject: ViewObject) {
        nameLabel.text = viewObject.heading
        profileImageView.loadImage(from: viewObject.thumbnailImageURL)
    }
}

final class CharacterDetailTableViewSectionHandler: SectionHandler {
    var listItemTypes: [ViewObject.Type] { [ListItemDTO.self] }

    func registerCell(_ viewRecycler: ViewRecycler) {
        viewRecycler.registerNib(recyclableView: CharacterDetailTableViewCell.self, bundle: nil)
    }

    func dequeueView(_ viewRecycler: ViewRecycler,
                     cellForListItem item: ViewObject,
                     atIndexPath indexPath: IndexPath) -> Recyclable {
        typealias CellType = CharacterDetailTableViewCell
        let cell: CellType! = viewRecycler.dequeueView(recyclableView: CellType.self,
                                                       for: indexPath)
        cell.update(item)
        return cell
    }
}

//
//  HeroListSectionHandler.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 24/02/22.
//

import Foundation
import UIComponents
import UIKit
import Network
import TinyConstraints

class HeroTableViewCell: UITableViewCell {
    lazy var headingLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.textColor = UIColor.white
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        return $0
    }(UILabel())

    lazy var profileImage: AsyncImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(AsyncImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImage)
        profileImage.heightToWidth(of: profileImage)
        profileImage.edgesToSuperview(insets: .vertical(20) + .horizontal(20))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        headingLabel.text = ""
    }
}

class CharacterDetailTableViewSectionHandler: SectionHandler {
    var listItemTypes: [ViewObject.Type] { [Character.self] }

    func registerCell(_ viewRecycler: ViewRecycler) {
        viewRecycler.registerViewClass(recyclableView: HeroTableViewCell.self)
    }

    func dequeueView(_ viewRecycler: ViewRecycler,
                     cellForListItem item: ViewObject,
                     atIndexPath indexPath: IndexPath) -> Recyclable {
        let cell: HeroTableViewCell! = viewRecycler.dequeueView(recyclableView: HeroTableViewCell.self, for: indexPath)

        guard let marvelHero = item as? Character else {
            return cell
        }

        cell.headingLabel.text = marvelHero.name
        cell.profileImage.loadImage(from: marvelHero.thumbnail?.url)
        return cell
    }
}

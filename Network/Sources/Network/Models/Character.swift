//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import Domain

public struct CharacterConstants {
    static let stories: String = NSLocalizedString("Stories", comment: "Stories")
    static let events: String = NSLocalizedString("Events", comment: "Events")
    static let comics: String = NSLocalizedString("Comics", comment: "Comics")
    static let series: String = NSLocalizedString("Series", comment: "Series")
}

public struct Character {
    public init(id: Int, name: String?, description: String?, thumbnail: Image?, comics: OtherItems?, series: OtherItems?, stories: OtherItems?, events: OtherItems?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }

    public let id: Int
    public let name: String?
    public let description: String?
    public let thumbnail: Image?
    public let comics: OtherItems?
    public let series: OtherItems?
    public let stories: OtherItems?
    public let events: OtherItems?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
        case comics
        case series
        case stories
        case events
    }
}

extension Character: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.thumbnail = try container.decodeIfPresent(Image.self, forKey: .thumbnail)
        self.comics = try container.decodeIfPresent(OtherItems.self, forKey: .comics)
        self.series = try container.decodeIfPresent(OtherItems.self, forKey: .series)
        self.stories = try container.decodeIfPresent(OtherItems.self, forKey: .stories)
        self.events = try container.decodeIfPresent(OtherItems.self, forKey: .events)
    }
}

extension Character {
    public func toListItemDTO() -> ListItemDTO {
        return ListItemDTO( id: self.id,
                            heading: self.name ?? "",
                            body: self.description ?? "",
                            thumbnailImageURL: self.thumbnail?.url)
    }
}

extension Character {
    public func toListItemDetailsDTO() -> CharacterDetailsDTO {
        let stories = CharacterOtherDetailsDTO(heading: CharacterConstants.stories,
                                               body: self.stories?.descriptionString() ?? "")
        let comics = CharacterOtherDetailsDTO(heading: CharacterConstants.comics,
                                              body: self.comics?.descriptionString() ?? "")
        let events = CharacterOtherDetailsDTO(heading: CharacterConstants.events,
                                              body: self.events?.descriptionString() ?? "")
        let series = CharacterOtherDetailsDTO(heading: CharacterConstants.series,
                                              body: self.series?.descriptionString() ?? "")

        return CharacterDetailsDTO(Id: self.id,
                                  headerDetails: self.toListItemDTO(),
                                  stories: stories,
                                  comics: comics,
                                  events: events,
                                  series: series,
                                  thumbnailImageURL: self.thumbnail?.url)
    }
}

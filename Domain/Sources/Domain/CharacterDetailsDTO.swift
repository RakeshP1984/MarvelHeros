//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public struct CharacterDetailsDTO {
    public init(Id: Int,
                headerDetails: ListItemDTO,
                stories: CharacterOtherDetailsDTO,
                comics: CharacterOtherDetailsDTO,
                events: CharacterOtherDetailsDTO,
                series: CharacterOtherDetailsDTO,
                thumbnailImageURL: URL? = nil) {
        self.Id = Id
        self.headerDetails = headerDetails
        self.stories = stories
        self.comics = comics
        self.events = events
        self.series = series
        self.thumbnailImageURL = thumbnailImageURL
    }

    public var Id: Int
    public var headerDetails: ListItemDTO
    public var stories: CharacterOtherDetailsDTO
    public var comics: CharacterOtherDetailsDTO
    public var events: CharacterOtherDetailsDTO
    public var series: CharacterOtherDetailsDTO
    public var thumbnailImageURL: URL?
}

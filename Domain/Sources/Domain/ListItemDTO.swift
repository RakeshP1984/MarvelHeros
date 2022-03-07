//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public struct ListItemDTO {
    public init(id: Int, heading: String, body: String, thumbnailImageURL: URL? = nil) {
        self.id = id
        self.heading = heading
        self.body = body
        self.thumbnailImageURL = thumbnailImageURL
    }

    public var id: Int
    public var heading: String
    public var body: String
    public var thumbnailImageURL: URL?
}

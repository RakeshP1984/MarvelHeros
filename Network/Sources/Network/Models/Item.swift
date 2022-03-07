//
//  File.swift
//  
//
//  Created by Rakesh Patole on 01/03/22.
//

import Foundation

public struct Item {
    public var resourceURI: String?
    public var name: String?

    public init(resourceURI: String? = nil, name: String? = nil) {
        self.resourceURI = resourceURI
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

extension Item: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

extension Item {
    public var url: URL? { URL(string: resourceURI ?? "" ) }
}

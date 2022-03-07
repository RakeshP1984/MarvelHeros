//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation

public struct Image {
    public let path: String?
    public let ext: String?

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension Image {
    public var url: URL? {
        guard let path = path, let ext = ext else {
            return nil
        }

        return URL(string: "\(path).\(ext)")
    }
}

extension Image: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.ext = try container.decodeIfPresent(String.self, forKey: .ext)
    }
}

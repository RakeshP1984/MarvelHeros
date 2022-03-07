//
//  File.swift
//  
//
//  Created by Rakesh Patole on 01/03/22.
//

import Foundation

public struct OtherItems {
    public var available: Int?
    public var items: [Item]?

    enum CodingKeys: String, CodingKey {
        case available
        case items
    }
}

extension OtherItems: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decodeIfPresent(Int.self, forKey: .available)
        self.items = try container.decodeIfPresent([Item].self, forKey: .items)
    }
}

extension OtherItems {
    public func descriptionString() -> String {
        return items?.map { $0.name ?? "" }.joined(separator: ",\n") ?? ""
    }
}

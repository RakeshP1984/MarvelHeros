//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import Domain

public struct PageData<ResultType: Decodable> {
    public let offset: Int?
    public let limit: Int?
    public let total: Int?
    public let count: Int?
    public let results: [ResultType]?

    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

extension PageData: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.results = try container.decodeIfPresent([ResultType].self, forKey: .results)
    }
}

extension PageData {
    public var pageNo: Int {
        let offset: Int = self.offset ?? 0
        let limit: Int = self.limit ?? 1
        return offset % limit
    }
}

extension PageData where ResultType == Character {
    func toListPageDTO() -> ListPageDTO {
        return ListPageDTO(pageNo: self.pageNo,
                           offset: self.offset ?? 0,
                           total: self.total ?? 0,
                           listItem: self.results?.map { $0.toListItemDTO() } ?? [ListItemDTO]())
    }
}

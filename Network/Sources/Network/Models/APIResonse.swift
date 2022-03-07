//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation

public struct APIResponse<ResultType: Decodable> {
    public let code: Int?
    public let status: String?
    public let data: PageData<ResultType>?

    enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
    }
}

extension APIResponse: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.data = try container.decodeIfPresent(PageData<ResultType>.self, forKey: .data)
    }
}

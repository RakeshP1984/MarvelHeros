//
//  File.swift
//  
//
//  Created by Rakesh Patole on 04/03/22.
//

import Foundation

public enum Endpoint {
    case searchCharacter(name: String, limit: Int?, offset: Int?)
    case getCharacterDetails(character: Character)
}

extension Endpoint {
    func path() -> String {
        switch self {
        case .searchCharacter:
            return "/characters"

        case .getCharacterDetails(let character):
            return "/characters/\(String(describing: character.id))"
        }
    }

    func params() -> [String: String]? {
        switch self {
        case .searchCharacter(let query, let limit, let offset):
            var params = [String: String]()
            if query.isEmpty == false {
                params["name"] = query
            }

            if let limit = limit {
                params["limit"] = String(describing: limit)
            }

            if let offset = offset {
                params["offset"] = String(describing: offset)
            }
            return params

        default: return nil
        }
    }
}

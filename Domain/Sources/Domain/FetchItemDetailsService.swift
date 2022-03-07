//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public enum FetchItemDetailsServiceError: LocalizedError, Equatable {
    case noItemFound
    case otherError(Error)

    public var errorDescription: String? {
        switch self {
        case .noItemFound: return NSLocalizedString("No such item found!!", comment: "")
        case .otherError(let error): return error.localizedDescription
        }
    }

    public static func == (lhs: FetchItemDetailsServiceError, rhs: FetchItemDetailsServiceError) -> Bool {
        switch (lhs, rhs) {
        case ( .noItemFound, .noItemFound):
            return true
        case ( .otherError(let error1), .otherError(let error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

public protocol FetchItemDetailsService {
    @discardableResult
    func fetchDetails( id: Int, completionHandler: @escaping (Result<CharacterDetailsDTO, FetchItemDetailsServiceError>) -> Void) -> Task
}

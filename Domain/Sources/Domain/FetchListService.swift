//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public enum ListFetchErrors: LocalizedError, Equatable {
    case noCharactersFound
    case otherError(Error)

    public var errorDescription: String? {
        switch self {
        case .noCharactersFound: return NSLocalizedString("No Charcters Found!!", comment: "")
        case .otherError(let error): return error.localizedDescription
        }
    }

    public static func == (lhs: ListFetchErrors, rhs: ListFetchErrors) -> Bool {
        switch (lhs, rhs) {
        case ( .noCharactersFound, .noCharactersFound):
            return true
        case ( .otherError(let error1), .otherError(let error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

public protocol FetchListService {
    @discardableResult
    func fetchList( name: String, limit: Int, offset: Int, completionHandler: @escaping (Result<ListPageDTO,ListFetchErrors>) -> Void) -> Task
}

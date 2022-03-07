//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation
import Domain

public final class FetchCharacterListService: FetchListService {
    var serviceProvider: ServiceProvider
    public init( serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    @discardableResult 
    public func fetchList(name: String,
                          limit: Int,
                          offset: Int,
                          completionHandler: @escaping (Result<ListPageDTO, ListFetchErrors>) -> Void) -> Task {
        typealias ResultType = Result<APIResponse<Character>, APIError>
        let task = serviceProvider.GET(endPoint: .searchCharacter(name: name, limit: limit, offset: offset), params: nil) { (result:ResultType )  in
            switch result {
            case .success(let response):
                if let pageData = response.data, pageData.total ?? 0 > 0 {
                    completionHandler(.success(pageData.toListPageDTO()))
                } else {
                    completionHandler(.failure(.noCharactersFound))
                }

            case .failure(let failure):
                completionHandler(.failure(.otherError(failure)))
            }
        }
        return task
    }
}

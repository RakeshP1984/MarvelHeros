//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation
import Domain

public final class FetchCharacterDetailsService: FetchItemDetailsService {
    var serviceProvider: ServiceProvider
    public init( serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    @discardableResult
    public func fetchDetails(id: Int, completionHandler: @escaping (Result<CharacterDetailsDTO, FetchItemDetailsServiceError>) -> Void) -> Task {
        let character = Character(id: id, name: nil, description: nil, thumbnail: nil, comics: nil, series: nil, stories: nil, events: nil)
        typealias ResultType = Result<APIResponse<Character>, APIError>
        let task = serviceProvider.GET(endPoint: .getCharacterDetails(character: character), params: nil) { (result: ResultType) in
            switch result {
            case .success(let response):
                let items: [Character] = response.data?.results ?? []
                if let item = items.first {
                    completionHandler(.success(item.toListItemDetailsDTO()))
                } else {
                    completionHandler(.failure(.noItemFound))
                }

            case .failure(let failure):
                completionHandler(.failure(.otherError(failure)))
            }
        }
        return task
    }
}

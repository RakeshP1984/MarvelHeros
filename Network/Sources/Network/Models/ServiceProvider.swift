//
//  File.swift
//  
//
//  Created by Rakesh Patole on 04/03/22.
//

import Foundation
import Domain

public protocol ServiceProvider {
    @discardableResult
    func GET<T:Decodable>( endPoint: Endpoint,
                           params: [String:String]?,
                           completionHandler:@escaping (Result<T,APIError>) -> Void) -> Task
}

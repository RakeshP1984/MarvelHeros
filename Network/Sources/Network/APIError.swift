//
//  File.swift
//  
//
//  Created by Rakesh Patole on 04/03/22.
//

import Foundation

public enum APIError: Error {
    case networkError(Error)
    case noResponse
    case jsonDecodingError(Error)
}

//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public protocol Task {
    func resume()
    func suspend()
    func cancel()
}

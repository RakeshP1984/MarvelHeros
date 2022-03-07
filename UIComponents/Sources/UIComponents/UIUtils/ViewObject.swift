//
//  File.swift
//  
//
//  Created by Rakesh Patole on 28/02/22.
//

import Foundation

public protocol ViewObject {
    var heading: String { get }
    var body: String { get }
    var thumbnailImageURL: URL? { get }
}

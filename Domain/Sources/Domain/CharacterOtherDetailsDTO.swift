//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public struct CharacterOtherDetailsDTO {
    public init(heading: String, body: String) {
        self.heading = heading
        self.body = body
    }

    public var heading: String
    public var body: String
}

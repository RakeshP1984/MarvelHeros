//
//  ListItemDetailsDTO+ViewObject.swift
//  MarvelHeros
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation
import Domain
import UIComponents

extension CharacterDetailsDTO: ViewObject {
    public var heading: String {
        return self.headerDetails.heading
    }

    public var body: String {
        return self.headerDetails.body
    }
}

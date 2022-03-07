//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import UIKit

public protocol SectionHandler {
    var listItemTypes: [ViewObject.Type] { get }
    func registerCell(_ viewRecycler: ViewRecycler)
    func dequeueView(_ viewRecycler: ViewRecycler,
                     cellForListItem item: ViewObject,
                     atIndexPath indexPath: IndexPath) -> Recyclable
}

public final class SectionContainer {
    lazy private var sectionHandlers: [SectionHandler] = [SectionHandler]()

    public required init( sectionHandlers: [SectionHandler]) {
        self.sectionHandlers = sectionHandlers
    }

    func registerCell(_ viewRecycler: ViewRecycler) {
        for sectionHandler in sectionHandlers {
            sectionHandler.registerCell(viewRecycler)
        }
    }

    func dequeueView(_ viewRecycler: ViewRecycler,
                     cellForListItem item: ViewObject,
                     atIndexPath indexPath: IndexPath) -> Recyclable {
        let listItemType = type(of: item)
        let sectionHandler = sectionHandlers.first { sectionHandler in
            sectionHandler.listItemTypes.contains { $0 == listItemType }
        }
        return sectionHandler!.dequeueView( viewRecycler, cellForListItem: item, atIndexPath: indexPath)
    }
}

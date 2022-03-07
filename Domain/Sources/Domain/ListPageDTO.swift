//
//  File.swift
//  
//
//  Created by Rakesh Patole on 03/03/22.
//

import Foundation

public struct ListPageDTO {
    public init(pageNo: Int, offset: Int, total: Int, listItem: [ListItemDTO]) {
        self.pageNo = pageNo
        self.offset = offset
        self.total = total
        self.listItem = listItem
    }
    
    public var pageNo: Int
    public var offset: Int
    public var total: Int
    public var listItem: [ListItemDTO]
}

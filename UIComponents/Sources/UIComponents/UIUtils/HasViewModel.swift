//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation

public protocol HasViewModel {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get }
}

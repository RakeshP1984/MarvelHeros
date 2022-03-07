//
//  File.swift
//  
//
//  Created by Rakesh Patole on 28/02/22.
//

import Foundation
import UIKit

public protocol Recyclable: AnyObject {
    static var identifier: String { get }
}

public extension Recyclable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Recyclable {}
extension UICollectionViewCell: Recyclable {}

public protocol ViewRecycler {
    func registerViewClass<T: Recyclable>(recyclableView: T.Type)
    func registerNib<T: Recyclable>(recyclableView: T.Type, bundle: Bundle?)
    func dequeueView<T: Recyclable>(recyclableView: T.Type, for indexPath: IndexPath) -> T?
}

extension UICollectionView: ViewRecycler {
    public func registerNib<T>(recyclableView: T.Type, bundle: Bundle?) where T: Recyclable {
        self.register(UINib(nibName: recyclableView.identifier, bundle: bundle),
                      forCellWithReuseIdentifier: recyclableView.identifier)
    }

    public func registerViewClass<T>(recyclableView: T.Type) where T: Recyclable {
        self.register(recyclableView.self, forCellWithReuseIdentifier: recyclableView.identifier)
    }

    public func dequeueView<T>(recyclableView: T.Type, for indexPath: IndexPath) -> T? where T: Recyclable {
        self.dequeueReusableCell(withReuseIdentifier: recyclableView.identifier, for: indexPath) as? T
    }
}

extension UITableView: ViewRecycler {
    public func registerNib<T>(recyclableView: T.Type, bundle: Bundle?) where T: Recyclable {
        self.register(UINib(nibName: recyclableView.identifier, bundle: bundle),
                      forCellReuseIdentifier: recyclableView.identifier)
    }

    public func registerViewClass<T>(recyclableView: T.Type) where T: Recyclable {
        self.register(recyclableView.self,
                      forCellReuseIdentifier: recyclableView.identifier)
    }

    public func dequeueView<T>(recyclableView: T.Type, for indexPath: IndexPath) -> T? where T: Recyclable {
        self.dequeueReusableCell(withIdentifier: recyclableView.identifier, for: indexPath) as? T
    }
}

//
//  Applyable.swift
//  Weather
//
//  Created by Roman Ivanov on 08.09.2022.
//

import Foundation

public protocol Applyable {}

public extension Applyable where Self: AnyObject {
    @discardableResult
    func apply(_ fun: (Self) throws -> Void) rethrows -> Self {
        try fun(self)
        return self
    }
}

extension NSObject: Applyable {}

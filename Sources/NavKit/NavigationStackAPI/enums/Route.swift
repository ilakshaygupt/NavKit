//
//  Route.swift
//  NavKit
//
//  Created by Lakshay Gupta on 28/03/25.
//

#if os(iOS)
import Foundation
import SwiftUI
public protocol Route: CaseIterable, Hashable {
    associatedtype ViewType: View
    func makeView() -> ViewType
}

public extension Route {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
}

// Type-erased wrapper to allow storing heterogeneous `Route` values
public struct AnyRoute: Hashable, CustomStringConvertible {
    private let makeAnyViewClosure: () -> AnyView
    private let describeClosure: () -> String
    private let hashClosure: (inout Hasher) -> Void
    private let equalsClosure: (AnyRoute) -> Bool

    public init<R: Route>(_ route: R) {
        self.makeAnyViewClosure = { AnyView(route.makeView()) }
        self.describeClosure = { String(describing: route) }
        self.hashClosure = { hasher in
            // Use description for hashing by default; concrete routes can override by conforming differently
            hasher.combine(String(describing: route))
        }
        self.equalsClosure = { other in
            // Fallback equality based on description
            return String(describing: route) == other.description
        }
    }

    public func makeView() -> AnyView {
        return makeAnyViewClosure()
    }

    public var description: String {
        return describeClosure()
    }

    public static func == (lhs: AnyRoute, rhs: AnyRoute) -> Bool {
        return lhs.equalsClosure(rhs)
    }

    public func hash(into hasher: inout Hasher) {
        hashClosure(&hasher)
    }
}
#endif

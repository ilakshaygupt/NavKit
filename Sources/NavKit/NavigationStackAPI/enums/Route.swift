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
#endif

//
//  NavigationDestination.swift
//  NavKit
//
//  Created by Lakshay Gupta on 28/03/25.
//

#if os(iOS)
import Foundation
import SwiftUI

public enum NavigationDestination {
    case view(AnyView)
    case route(any Route)
    
    public init<T: View>(_ view: T) {
        self = .view(AnyView(view))
    }
    
    public init<R: Route>(_ route: R) {
        self = .route(route)
    }
    
    var view: AnyView {
        switch self {
        case .view(let view):
            return view
        case .route(let route):
            return AnyView(route.makeView())
        }
    }
}
#endif

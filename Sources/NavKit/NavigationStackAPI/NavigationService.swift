//
//  NavigationService.swift
//  NavKit
//
//  Created by Lakshay Gupta on 28/03/25.
//


#if os(iOS)
import Foundation
import UIKit

import SwiftUI

@MainActor
public class NavigationService: ObservableObject {
    public static let shared = NavigationService()

    private var navigationController: UINavigationController?
    private let transitionDelegate = NavigationTransitionDelegate()

    private init() {}

    public func setup(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.delegate = transitionDelegate
    }

    // Push a new view
    public func push<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        push(NavigationDestination(view), transition: transition, animated: animated)
    }
    
    // Push a new route
    public func push<R: Route>(_ route: R, transition: TransitionType? = nil, animated: Bool = true) {
        push(NavigationDestination(route), transition: transition, animated: animated)
    }
    
    public func push(_ destination: NavigationDestination, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: destination.view)
            print("Pushing destination: \(destination)")
            self?.navigationController?.pushViewController(hostingController, animated: animated)
        }
    }

    public func pushAsRoot<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        pushAsRoot(NavigationDestination(view), transition: transition, animated: animated)
    }
    
    // Push a route as root
    public func pushAsRoot<R: Route>(_ route: R, transition: TransitionType? = nil, animated: Bool = true) {
        pushAsRoot(NavigationDestination(route), transition: transition, animated: animated)
    }
    
    public func pushAsRoot(_ destination: NavigationDestination, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let navigationController = self?.navigationController else {
                print("Error: NavigationController is not set.")
                return
            }
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: destination.view)
            navigationController.setViewControllers([hostingController], animated: animated)
            print("Root destination set successfully.")
        }
    }



    public func pushAndReplace<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        pushAndReplace(NavigationDestination(view), transition: transition, animated: animated)
    }
    
    public func pushAndReplace(_ destination: NavigationDestination, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard var viewControllers = self?.navigationController?.viewControllers else { return }
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: destination.view)
            viewControllers.removeLast()
            viewControllers.append(hostingController)  
            self?.navigationController?.setViewControllers(viewControllers, animated: animated)
        }
    }

    // Push a route and replace current
    public func pushAndReplace<R: Route>(_ route: R, transition: TransitionType? = nil, animated: Bool = true) {
        pushAndReplace(NavigationDestination(route), transition: transition, animated: animated)
    }


    // Pop current view
    public func pop(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popViewController(animated: animated)
        }
    }


    public func popToRoot(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popToRootViewController(animated: animated)
        }
    }


    public func popToIndex(_ index: Int, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let viewControllers = self?.navigationController?.viewControllers,
                  index < viewControllers.count else { return }
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popToViewController(viewControllers[index], animated: animated)
        }
    }
    
    // Pop until specified view type is reached
    public func popUntil<T: View>(_ viewType: T.Type, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let navigationController = self?.navigationController else { return }
            
            let viewControllers = navigationController.viewControllers
            for (index, viewController) in viewControllers.enumerated().reversed() {
                if let hostingController = viewController as? UIHostingController<T> {
                    self?.transitionDelegate.currentTransition = .pop
                    navigationController.popToViewController(hostingController, animated: animated)
                    return
                }
            }
            print("Warning: View of type \(viewType) not found in navigation stack")
        }
    }
    
    // Pop until specified destination is reached
    public func popUntil(_ destination: NavigationDestination, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let navigationController = self?.navigationController else { return }
            
            let viewControllers = navigationController.viewControllers
            for viewController in viewControllers.reversed() {
                if let hostingController = viewController as? UIHostingController<AnyView> {
                    // For routes, we'll use a more reliable approach by checking the route's string representation
                    if case .route(let route) = destination {
                        let routeString = String(describing: route)
                        // This is a simple heuristic - in a real app you might want to add view identifiers
                        if String(describing: hostingController.rootView).contains(routeString) {
                            self?.transitionDelegate.currentTransition = .pop
                            navigationController.popToViewController(hostingController, animated: animated)
                            return
                        }
                    } else if case .view(let targetView) = destination {
                        // For direct views, we can try to match by type
                        if String(describing: hostingController.rootView) == String(describing: targetView) {
                            self?.transitionDelegate.currentTransition = .pop
                            navigationController.popToViewController(hostingController, animated: animated)
                            return
                        }
                    }
                }
            }
            print("Warning: Destination not found in navigation stack")
        }
    }
    
    // Pop until specified route is reached (convenience method)
    public func popUntil<R: Route>(_ route: R, animated: Bool = true) {
        popUntil(NavigationDestination(route), animated: animated)
    }


    public var canPop: Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }


    public var stackCount: Int {
        return navigationController?.viewControllers.count ?? 0
    }
}

#endif

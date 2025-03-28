#if os(iOS)
import Foundation
import UIKit

import SwiftUI

@MainActor
class NavigationService: ObservableObject {
    static let shared = NavigationService()

    private var navigationController: UINavigationController?
    private let transitionDelegate = NavigationTransitionDelegate()

    private init() {}

    func setup(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.delegate = transitionDelegate
    }

    // Push a new view
    func push<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: view)
            print("Pushing view: \(view)")
            self?.navigationController?.pushViewController(hostingController, animated: animated)
        }
    }

    func pushAsRoot<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let navigationController = self?.navigationController else {
                print("Error: NavigationController is not set.")
                return
            }
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: view)
            navigationController.setViewControllers([hostingController], animated: animated)
            print("Root view set successfully.")
        }
    }



    func pushAndReplace<T: View>(_ view: T, transition: TransitionType? = nil, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard var viewControllers = self?.navigationController?.viewControllers else { return }
            self?.transitionDelegate.currentTransition = transition
            let hostingController = UIHostingController(rootView: view)
            viewControllers.removeLast()
            viewControllers.append(hostingController)  
            self?.navigationController?.setViewControllers(viewControllers, animated: animated)
        }
    }


    // Pop current view
    func pop(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popViewController(animated: animated)
        }
    }


    func popToRoot(animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popToRootViewController(animated: animated)
        }
    }


    func popToIndex(_ index: Int, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let viewControllers = self?.navigationController?.viewControllers,
                  index < viewControllers.count else { return }
            self?.transitionDelegate.currentTransition = .pop
            self?.navigationController?.popToViewController(viewControllers[index], animated: animated)
        }
    }


    var canPop: Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }


    var stackCount: Int {
        return navigationController?.viewControllers.count ?? 0
    }
}

#endif
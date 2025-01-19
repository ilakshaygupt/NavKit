//
//  AppDelegate.swift
//  NavigationStackAPI
//
//  Created by Lakshay Gupta on 14/01/25.
//


import UIKit
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Handle deep link
        handleDeepLink(url: url)
        return true
    }
    
    private func handleDeepLink(url: URL) {
        guard url.scheme == "NavigationStackAPI", url.host == "navigate" else {
            print("Invalid deep link")
            return
        }
        
        let pathComponents = url.pathComponents
        if pathComponents.count > 2, let pageNo = Int(pathComponents[2]) {
            DispatchQueue.main.async {
                NavigationService.shared.push(DynamicView(pageNo: pageNo), transition: .fade)
            }
        } else {
            print("Invalid deep link structure")
        }
    }
}

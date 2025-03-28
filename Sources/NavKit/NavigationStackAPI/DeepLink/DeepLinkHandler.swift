//
//  DeepLinkHandler.swift
//  NavigationStackAPI
//
//  Created by Lakshay Gupta on 14/01/25.
//
import SwiftUI

@MainActor
class DeepLinkHandler {
    static func handle(url: URL) {
        guard let host = url.host else { return }


        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        let pathParam = queryItems?.first(where: { item in
            item.name == "path"
        })?.value

        let navigationPath: [String]
        if let pathParam = pathParam {
            navigationPath = pathParam.components(separatedBy: ",")
        } else {
            navigationPath = []
        }

        // Parse destination
        let pathComponents = url.pathComponents
        if host == "navigate", pathComponents.count > 2 {
            let screenType = pathComponents[1]
            let pageNo = Int(pathComponents[2]) ?? 1

            DispatchQueue.main.async {
                navigateWithPath(screenType: screenType, pageNo: pageNo, path: navigationPath)
            }
        }
    }

    static func navigateWithPath(screenType: String, pageNo: Int, path: [String]) {

        for screen in path {
            let components = screen.components(separatedBy: ":")
            let screenType = components[0]
            let pageNo = components.count > 1 ? Int(components[1]) ?? 1 : 1

            switch screenType {
                case "screen":
                    NavigationService.shared.push(DynamicView(pageNo: pageNo))
                case "profile":
                    NavigationService.shared.push(ProfileView())
                case "settings":
                    NavigationService.shared.push(SettingsView())
                default:
                    print("Unknown screen in path: \(screenType)")
            }
        }


        switch screenType {
            case "screen":
                NavigationService.shared.push(DynamicView(pageNo: pageNo), transition: .slide(direction: .right))
            case "profile":
                NavigationService.shared.push(ProfileView(), transition: .fade)
            case "settings":
                NavigationService.shared.push(SettingsView(), transition: .scale)
            default:
                print("Unknown screen type: \(screenType)")
        }
    }
}

import SwiftUI
import UIKit


// Learn more @ https://developer.apple.com/documentation/swiftui/UIViewControllerRepresentable
struct NavigationContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let rootView = MainTabView()
        let hostingController = UIHostingController(rootView: rootView)
        let navigationController = UINavigationController(rootViewController: hostingController)
        NavigationService.shared.setup(with: navigationController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
} 
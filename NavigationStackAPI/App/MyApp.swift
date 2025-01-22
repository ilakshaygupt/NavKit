import SwiftUI

@main
struct MyApp: App {
    // Learn more @ https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationContainerView()
                .ignoresSafeArea()
                .onOpenURL { url in
                    DeepLinkHandler.handle(url:url)
                }

        }
    }
} 

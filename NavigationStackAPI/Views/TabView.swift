import SwiftUI
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            NavigationView {
                DynamicView(pageNo: 1)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
    }
}


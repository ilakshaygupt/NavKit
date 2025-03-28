import SwiftUI

struct RootView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Root View")
                .font(.largeTitle)
            
            Button(action: {
                NavigationService.shared.push(DynamicView(pageNo: 1), transition: .fade)
            }) {
                Text("Go to Next Screen")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }



        }
        .padding()
    }
} 

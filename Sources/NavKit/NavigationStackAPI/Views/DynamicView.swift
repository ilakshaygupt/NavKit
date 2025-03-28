import SwiftUI

struct DynamicView: View {
    var pageNo: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Screen \(pageNo)")
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            // Basic Navigation
            Group {
                Text("Basic Navigation")
                    .font(.headline)
                
                Button("Push Screen \(pageNo + 1)") {
                    NavigationService.shared.push(DynamicView(pageNo: pageNo + 1))
                }
                
                Button("Push and Replace with Screen \(pageNo + 1)") {
                    NavigationService.shared.pushAndReplace(DynamicView(pageNo: pageNo + 1))
                }
                
                Button("Set Screen \(pageNo + 1) as Root") {
                    NavigationService.shared.pushAsRoot(DynamicView(pageNo: pageNo + 1))
                }
            }
            .buttonStyle(.bordered)
            
            // Transitions
            Group {
                Text("Transitions")
                    .font(.headline)
                    .padding(.top)
                
                Button("Push with Fade") {
                    NavigationService.shared.push(
                        DynamicView(pageNo: pageNo + 1),
                        transition: .fade
                    )
                }
                
                Button("Push with Scale") {
                    NavigationService.shared.push(
                        DynamicView(pageNo: pageNo + 1),
                        transition: .scale
                    )
                }
                
                Button("Slide from Right") {
                    NavigationService.shared.push(
                        DynamicView(pageNo: pageNo + 1),
                        transition: .slide(direction: .right)
                    )
                }
                
                Button("Slide from Left") {
                    NavigationService.shared.push(
                        DynamicView(pageNo: pageNo + 1),
                        transition: .slide(direction: .left)
                    )
                }
            }
            .buttonStyle(.bordered)
            
            // Pop Operations
            Group {
                Text("Pop Operations")
                    .font(.headline)
                    .padding(.top)
                
                Button("Pop") {
                    NavigationService.shared.pop()
                }
                .disabled(!NavigationService.shared.canPop)
                
                Button("Pop to Root") {
                    NavigationService.shared.popToRoot()
                }
                .disabled(!NavigationService.shared.canPop)
                
                if pageNo > 2 {
                    Button("Pop to Screen 2") {
                        NavigationService.shared.popToIndex(1)
                    }
                }
            }
            .buttonStyle(.bordered)
            
            Spacer()
            
            Text("Current Stack Depth: \(NavigationService.shared.stackCount)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}


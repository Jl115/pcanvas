//
//  HomeView.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI

struct DashBoardView: View {
    @State private var selectedItem: String? = "home" // Track the selected item
    @State private var isRightSidebarVisible: Bool = false // Toggle right sidebar
    var body: some View {
          ZStack {
              // Main NavigationSplitView
              NavigationSplitView {
                  SideBarView(selectedItem: $selectedItem)
                      .frame(minWidth: 100, idealWidth: 150, maxWidth: 500)
              } detail: {
                  // Displaying different views
                  switch selectedItem {
                  case "home":
                      HomeView()
                  case "settings":
                      SettingsView()
                  default:
                      Text("Please select an item")
                          .foregroundColor(.gray)
                  }
              }
              .inspector(isPresented: $isRightSidebarVisible, content: {
                  SideBarRight(isRightSidebarVisible: $isRightSidebarVisible)
              })

              // Floating Button when the inspector is closed
              if !isRightSidebarVisible {
                  VStack {
                      HStack {
                          Spacer()
                          Button(action: {
                              isRightSidebarVisible = true // Open the right sidebar
                          }) {
                              Image(systemName: "sidebar.right")
                                  .font(.title2)
                          }
                          .padding()
                      }
                      Spacer()
                  }
              }
          }
      }

}


#Preview {
    DashBoardView()
}

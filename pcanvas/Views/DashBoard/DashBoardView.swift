//
//  HomeView.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI

struct DashBoardView: View {
    @State private var selectedItem: String? = "home"
    @State private var isRightSidebarVisible: Bool = false

    var body: some View {
        ZStack {
            NavigationSplitView {
                SideBarView(selectedItem: $selectedItem)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 500)
            } detail: {
                Group {
                    switch selectedItem {
                    case "home":
                        HomeView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .toolbar {
                                ToolbarItem(
                                    id: "sideBarToggle",
                                    placement: .topBarTrailing
                                ) {
                                    Button(action: {
                                        isRightSidebarVisible.toggle()
                                    }) {
                                        Image(systemName: "sidebar.right")
                                    }
                                }
                            }
                    case "settings":
                        SettingsView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(UIColor.systemBackground))
                    default:
                        Text("Please select an item")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .toolbar {
                ToolbarItem(id: "sideBarToggle", placement: .topBarLeading) {
                    Button(action: {
                        isRightSidebarVisible.toggle()
                        print("isRightSidebarVisible: \(isRightSidebarVisible)")
                    }) {
                        Image(systemName: "sidebar.right")
                    }
                }
            }
            .inspector(isPresented: $isRightSidebarVisible) {
                SideBarRight(isRightSidebarVisible: $isRightSidebarVisible)
                    .zIndex(1)
            }
        }
    }
}



#Preview {
    DashBoardView()
}

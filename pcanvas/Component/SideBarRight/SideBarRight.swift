//
//  SideBarRight.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI
//this is the initial sidebar right
struct SideBarRight: View {
    @Binding var isRightSidebarVisible: Bool

    var body: some View {
        List() {
                    Text("Home")
                        .tag("home")
                    Text("Settings")
                        .tag("settings")
                }
        .toolbar {
            // Top toolbar
            //TODO: Need to descide what comese here
//            ToolbarItemGroup(placement: .navigationBarLeading) {
//                Button {
//                    print("Button 1 tapped")
//                } label: {
//                    Label("Button 1", systemImage: "plus")
//                }
//
//                Button {
//                    print("Button 2 tapped")
//                } label: {
//                    Label("Button 2", systemImage: "minus")
//                }
//            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    print("Create Folder tapped")
                } label: {
                    Label("Bottom 1", systemImage: "folder.badge.plus")
                }

                Button {
                    print("Create Notes Tapped")
                } label: {
                    Label("Bottom 1", systemImage: "square.and.pencil")
                }
            }

            // Bottom toolbar
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    print("Bottom Button 2 tapped")
                } label: {
                    Label("Bottom 2", systemImage: "trash")
                }
                Button {
                    
                } label: {
                    Label("Button 3", systemImage: "gear")
                        .tag("settings")
                }
            }
        }
    }
}

#Preview {
    DashBoardView()
}

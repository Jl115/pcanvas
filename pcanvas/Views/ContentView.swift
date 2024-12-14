//
//  ContentView.swift
//  pcanvas
//
//  Created by jldev on 12.12.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var fullText: String = "This is some editable text..."
    var body: some View {
        DashBoardView()
    }
}

#Preview {
    ContentView( )
        .modelContainer(for: Item.self, inMemory: true)
}

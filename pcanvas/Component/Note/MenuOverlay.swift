//
//  MenuOverlay.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI

struct MenuOverlay: View {
    let onSelectType: (NoteObjectTypeText) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(NoteObjectTypeText.allCases, id: \.self) { type in
                Button(action: {
                    onSelectType(type)
                }) {
                    Text(type.rawValue.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                }
            }
        }
        .padding()
    }
}

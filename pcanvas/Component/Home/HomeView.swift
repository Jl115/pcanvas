//
//  HomeView.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @State private var textObjects: [NoteObjectText] = [
        NoteObjectText(type: .headingLarge, content: "Large Heading"),
        NoteObjectText(type: .paragraph, content: "This is a sample paragraph."),
        NoteObjectText(type: .code, content: "let x = 10;")
    ]
    @State private var editingIndex: Int? = 0
    @State private var showMenuAtIndex: Int? = nil // Track if the "/" menu should be shown

    var body: some View {
        GeometryReader { geometry in
            ScrollView { // Enable scrolling for long content
                VStack(spacing: 0) {
                    ForEach(textObjects.indices, id: \.self) { index in
                        ZStack {
                            CustomTextView(
                                text: $textObjects[index].content,
                                isFocused: editingIndex == index,
                                type: textObjects[index].type
                            ) { key in
                                handleKeyPress(key, currentIndex: index)
                            }
                            .frame(maxWidth: .infinity) // Stretch to fill width
                            .frame(height: dynamicHeight(for: textObjects[index].content))

                            // Menu overlay for the "/" key
                            if showMenuAtIndex == index {
                                MenuOverlay { selectedType in
                                    textObjects[index].type = selectedType
                                    showMenuAtIndex = nil // Close the menu
                                }
                                .frame(width: 200, height: 150)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                            }
                        }
                    }

                    // Automatically add a new empty line at the end
                    Button(action: addEmptyLine) {
                        Text("Add New Line")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            .padding(.vertical, 8)
                    }
                }
                .frame(maxWidth: .infinity) // Center horizontally in the scroll view
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height,
                    alignment: .top // Align content at the top
                )
            }
        }
        .padding(.horizontal, 200) // Add 200 points padding on both sides
        .toolbar {
            ToolbarItem(id: "sideBarLeft", placement: .navigationBarTrailing) {
                Button(action: {
                    print("Toggle sidebar")
                }) {
                    Image(systemName: "pencil.and.scribble")
//                                    .font(.title2)
                }
            }
        }
    }

    private func handleKeyPress(_ key: KeyPressType, currentIndex: Int) {
        switch key {
        case .upArrow:
            moveFocus(to: currentIndex - 1)
        case .downArrow:
            moveFocus(to: currentIndex + 1)
        case .other:
            // Detect "/" for menu or Shift+Enter for new line
            if let text = textObjects[currentIndex].content.last, text == "/" {
                showMenuAtIndex = currentIndex
            } else  /* Detect Shift+Enter */ {
                addNewLine(below: currentIndex)
            }
        }
    }

    private func addEmptyLine() {
        textObjects.append(NoteObjectText(type: .paragraph, content: ""))
    }

    private func addNewLine(below index: Int) {
        textObjects.insert(NoteObjectText(type: .paragraph, content: ""), at: index + 1)
        moveFocus(to: index + 1)
    }

    private func moveFocus(to newIndex: Int) {
        guard newIndex >= 0 && newIndex < textObjects.count else { return }
        editingIndex = newIndex
    }

    private func dynamicHeight(for content: String) -> CGFloat {
        let lines = content.components(separatedBy: "\n").count
        let lineHeight: CGFloat = 24 // Approximate line height
        return max(CGFloat(lines) * lineHeight, 30) // Minimum height is 30
    }
}





enum KeyPressType {
    case upArrow
    case downArrow
    case other
}



// Simplified Note Class
struct Note {
    var textObject: [NoteObjectText]
    var canvasObject: [NoteObjectCanvas]
    var noteCategory: NoteCategory?
}

struct NoteCategory {
    var name: String
}

// NoteObjectText
struct NoteObjectText: Identifiable {
    var id = UUID()
    var type: NoteObjectTypeText
    var position: CGPoint?
    var size: CGSize?
    var content: String
    var contentRendered: String?
}

// NoteObjectCanvas
struct NoteObjectCanvas: Identifiable {
    var id = UUID()
    var type: NoteObjectTypeCanvas
    var position: CGPoint?
    var size: CGSize?
    var content: String?
    var contentRendered: String?
}

// Text Object Types
enum NoteObjectTypeText: String, CaseIterable {
    case headingSmall
    case headingMedium
    case headingLarge
    case paragraph
    case image
    case code
    case todo
}

// Canvas Object Types
enum NoteObjectTypeCanvas: String {
    case rectangle
    case circle
    case triangle
    case ellipse
    case line
    case polygon
    case polyline
    case paragraph
    case image
    case code
    case todo
}


#Preview {
    DashBoardView()
}

//
//  TexView.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI
import UIKit

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    var isFocused: Bool
    var type: NoteObjectTypeText
    var onKeyPress: (KeyPressType) -> Void

    func makeUIView(context: Context) -> CustomUITextView {
        let textView = CustomUITextView()
        textView.delegate = context.coordinator
        textView.onKeyPress = onKeyPress

        // Configure text view for compact layout
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero // No internal padding
        textView.textContainer.lineFragmentPadding = 0 // Remove default padding
        textView.font = fontForType(type)
        textView.text = text
        textView.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return textView
    }

    func updateUIView(_ uiView: CustomUITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        if isFocused {
            uiView.becomeFirstResponder()
        }
        uiView.font = fontForType(type)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView

        init(_ parent: CustomTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }

    private func fontForType(_ type: NoteObjectTypeText) -> UIFont {
        switch type {
        case .headingLarge:
            return UIFont.boldSystemFont(ofSize: 24)
        case .headingMedium:
            return UIFont.boldSystemFont(ofSize: 20)
        case .paragraph:
            return UIFont.systemFont(ofSize: 16)
        case .code:
            return UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        default:
            return UIFont.systemFont(ofSize: 16)
        }
    }
}





#Preview {
    HomeView()
}

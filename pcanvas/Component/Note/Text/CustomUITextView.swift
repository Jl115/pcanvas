//
//  CustomUITextView.swift
//  pcanvas
//
//  Created by jldev on 14.12.2024.
//

import SwiftUI
import UIKit

class CustomUITextView: UITextView {
    var onKeyPress: ((KeyPressType) -> Void)?

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key else { return }
        if key.keyCode == .keyboardUpArrow {
            onKeyPress?(.upArrow)
        } else if key.keyCode == .keyboardDownArrow {
            onKeyPress?(.downArrow)
        } else if key.keyCode == .keyboardReturn && key.modifierFlags.contains(.shift) {
            onKeyPress?(.other)
        } else {
            onKeyPress?(.other)
        }
    }
}

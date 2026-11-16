
//
//  Untitled.swift
//  Journali
//
//  Created by warood on 05/06/1448 AH.
//

import SwiftUI

enum JournaliColors {

    // MARK: - Primary / Accent
    static let primary = Color(
        light: Color(red: 127/255, green: 129/255, blue: 255/255),
        dark: Color(red: 127/255, green: 129/255, blue: 255/255)
    )

    // MARK: - Accent Text
    static let accentText = Color(
        light: Color(red: 98/255, green: 83/255, blue: 201/255),
        dark: Color(red: 175/255, green: 153/255, blue: 253/255)
    )

    // MARK: - Primary Text
    static let primaryText = Color(
        light: .black,
        dark: .white
    )

    // MARK: - Secondary Text
    static let secondaryText = Color(
        light: Color(red: 100/255, green: 100/255, blue: 110/255),
        dark: Color(red: 163/255, green: 154/255, blue: 154/255)
    )

    // MARK: - Card Background
    static let card = Color(
        light: Color(red: 242/255, green: 242/255, blue: 247/255),
        dark: Color(red: 28/255, green: 28/255, blue: 30/255)
    )

    // MARK: - Destructive
    static let destructive = Color(
        light: Color(red: 253/255, green: 69/255, blue: 60/255),
        dark: Color(red: 253/255, green: 69/255, blue: 60/255)
    )

    // MARK: - Background
    static let background = Color(
        light: .white,
        dark: .black
    )

    // MARK: - Editor Background
    static let editorBackground = Color(
        light: .white,
        dark: .black
    )

    // MARK: - Button Background
    static let buttonBackground = card

    // MARK: - Save Button Text
    static let saveButtonText = Color.white

    // MARK: - Placeholder Text
    static let placeholderText = secondaryText

    // MARK: - Border
    static let border = Color(
        light: Color.black.opacity(0.08),
        dark: Color.white.opacity(0.10)
    )
}

// MARK: - Dynamic Color Support
extension Color {

    init(light: Color, dark: Color) {
        self.init(
            uiColor: UIColor { traits in
                traits.userInterfaceStyle == .dark
                    ? UIColor(dark)
                    : UIColor(light)
            }
        )
    }
}

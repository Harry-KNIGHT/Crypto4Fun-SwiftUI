//
//  ViewModifier.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import Foundation
import SwiftUI

struct ButtonTimeSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.primary)
    }
}

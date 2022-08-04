//
//  GameBetCustomShape.swift
//  Crypto4Fun
//
//  Created by Nyl Neuville on 02/08/2022.
//

import Foundation
import SwiftUI

struct GameBetCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99412*width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 1.00216*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 1.00216*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0.68112*height))
        path.addLine(to: CGPoint(x: 0.8521*width, y: 0.63232*height))
        path.addLine(to: CGPoint(x: 0.8521*width, y: 0.3659*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0.31182*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.99412*width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 1.00216*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 1.00216*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0.68112*height))
        path.addLine(to: CGPoint(x: 0.8521*width, y: 0.63232*height))
        path.addLine(to: CGPoint(x: 0.8521*width, y: 0.3659*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0.31182*height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: 0))
        path.closeSubpath()
        return path
    }
}

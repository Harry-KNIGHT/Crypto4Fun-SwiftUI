//
//  Float.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI

extension Float {
	
	var twoDigitFloat: String {
		String(format: "%.2f", self)
	}
	var positiveOrNegativeColor: Color {
		(self > 0 ? Color.green : Color.red)
	}

	var plusOrMinusIndicator: String {
		(self == 0 ? "" : self > 0 ? "+" : "")
	}
}

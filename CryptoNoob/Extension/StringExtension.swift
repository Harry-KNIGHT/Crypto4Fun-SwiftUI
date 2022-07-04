//
//  StringExtension.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 04/07/2022.
//

import Foundation

extension Double {
	var stringWithoutZeroFraction: String {
		return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f") : String(self)
	}
}

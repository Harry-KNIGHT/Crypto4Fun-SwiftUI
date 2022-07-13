//
//  ChartModel.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 04/07/2022.
//

import Foundation

struct CurrencyChartResponse: Codable {
	let prices, marketCaps, totalVolumes: [[Double]]

	enum CodingKeys: String, CodingKey {
		case prices
		case marketCaps = "market_caps"
		case totalVolumes = "total_volumes"
	}
}

enum EpochUnixTime: String, CaseIterable {
	case day = "86400"
	case week = "604800"
	case month = "2419200"
	case year = "29030400"
	case max = "450000000"
}

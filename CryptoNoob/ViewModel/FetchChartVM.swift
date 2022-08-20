//
//  FetchChartApi.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 13/07/2022.
//

import Foundation
import Crypto4FunKit
protocol FetchChart {
	var prices: [[Double]] { get set }
	//var averagePrice: Double { get set }
	//var pricePercentageValue: Double { get set }
	func getChart(_ id: String, from firstDay: Double, to today: Double) async throws
}

class FetchChartApi: ObservableObject, FetchChart {
	@Published var prices: [[Double]] = [[Double]]()
	var averagePrice: Double {
		let valueArray = prices.map { $0[1] }
		let sum = valueArray.reduce(0, +)

		return sum / Double(valueArray.count)
	}

	var pricePercentageValue: Double {
		let priceValue = prices.map { $0[1] }
		let longTimePrice = Double(priceValue.first ?? 0)
		let actualPrice = Double(priceValue.last ?? 0)

		let percentagePrice =  (actualPrice - longTimePrice) / longTimePrice * 100

		return percentagePrice
	}

	@MainActor func getChart(_ id: String, from firstDate: Double, to today: Double = Date().timeIntervalSince1970) async throws {
		do {
			let data = try await ChartApi.fetchChart(id, from: firstDate)
			prices = data.prices
		} catch {
			throw error
		}
	}
}

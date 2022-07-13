//
//  FetchChartApi.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 13/07/2022.
//

import Foundation
protocol FetchChart {
	var prices: [[Double]] { get set }
	//var averagePrice: Double { get set }
	//var pricePercentageValue: Double { get set }

	func fetchChart(_ id: String, from firstDay: Double, to today: Double) async

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

	func fetchChart(_ id: String, from firstDate: Double, to today: Double = Date().timeIntervalSince1970) async {
		let url = "https://api.coingecko.com/api/v3/coins/\(id)/market_chart/range?vs_currency=usd&from=\(firstDate)&to=\(today)"

		guard let url = URL(string: url) else {
			print("Invalid url")
			return
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)

			if let decodedResponse = try? JSONDecoder().decode(CurrencyChartResponse.self, from: data) {
				DispatchQueue.main.async {
					self.prices = decodedResponse.prices
				}
			}
		} catch {
			print("Invalid url chart request")
		}
	}
}

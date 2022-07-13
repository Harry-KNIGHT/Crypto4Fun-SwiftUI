//
//  CryptoCurrencyApi.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 13/07/2022.
//

import Foundation

protocol cryptoCurrencyApi {
	//var timeRemaining: Int { get set }
	func fetchCryptoCurrency() async
	//func fetchDataTimer()
}

@MainActor class FetchCryptoCurrencyApi: ObservableObject, cryptoCurrencyApi {
	@Published public var cryptoCurrencies = [CryptoCurrencyModel]()
	@Published var timeRemaining: Int = 10

	public var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


	func fetchCryptoCurrency() async {
		let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=%271h%2C%2024h%2C%207d"

		guard let url = URL(string: url) else {
			print("Invalid url")
			return
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)

			if let decodedResponse = try? JSONDecoder().decode([CryptoCurrencyModel].self, from: data) {
				DispatchQueue.main.async {
					self.cryptoCurrencies = decodedResponse
				}
			}
		} catch {
			print("Invalid request")
		}
	}

	func fetchDataTimer() {
		if timeRemaining > 0 {
			timeRemaining -= 1
		} else {
			Task {
				await fetchCryptoCurrency()
				timeRemaining += 10
			}
		}
	}
}

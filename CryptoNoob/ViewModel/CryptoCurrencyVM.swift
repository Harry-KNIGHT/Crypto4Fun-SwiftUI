//
//  CryptoCurrencyApi.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 13/07/2022.
//

import Foundation
import Crypto4FunKit


 class CryptoViewModel: ObservableObject {
	@Published public var cryptoCurrencies: [CryptoCurrencyModel] = [CryptoCurrencyModel]()

	@Published public var timeRemaining: Int = 10
	@MainActor public var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

	@MainActor func getCryptos() {
		Task {
			do {
				cryptoCurrencies = try await CryptoApi.fetchCryptoCurrency()
			} catch {
				print("Error")
			}
		}
	 }

	func fetchDataTimer() {
		if timeRemaining > 0 {
			timeRemaining -= 1
		} else {
			Task {
				await getCryptos()
			}
			timeRemaining += 10
		}
	}

}

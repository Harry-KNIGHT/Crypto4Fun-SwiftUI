//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation

@MainActor class ApiCall: ObservableObject {
    @Published public var cryptoCurrencies = [CryptoCurrencyModel]()
    @Published public var timeRemaining = 10
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Published public var prices = [[Double]]()

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

    @Published public var timeToShow: TimeToShow = .monthly

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

    func fetchChart(_ id: String, timeChartShow: TimeToShow) async {
        let url = "https://api.coingecko.com/api/v3/coins/\(id)/market_chart?vs_currency=usd&days=\(timeChartShow.rawValue)&interval=daily"

        guard let url = URL(string: url) else {
            print("Invalid url")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(CurrencyChartResponse.self, from: data) {
                DispatchQueue.main.async {
					print("Succes request for currency: \(id), time: \(timeChartShow) in chart")
                    self.prices = decodedResponse.prices
                }
            }
        } catch {
            print("Invalid url chart request")
        }
    }


	func fetchDailyChart(_ id: String, from yesterday: Double = (Date().timeIntervalSince1970 - 86400), to today: Double = Date().timeIntervalSince1970) async {
	 let url = "https://api.coingecko.com/api/v3/coins/\(id)/market_chart/range?vs_currency=usd&from=\(yesterday)&to=\(today)"

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

    @Published public var nft = [NFTModel]()

	func fetchNFT(_ timeRange: NftTimeRange) async {
		let url = "https://api.cryptoslam.io/v1/collections/top-100?timeRange=\(timeRange.rawValue)"

        guard let url = URL(string: url) else {
            print("Invalid NFT url")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
				print("Bad http response")
				return
			}

            if let decodedResponse = try? JSONDecoder().decode([NFTModel].self, from: data) {
                DispatchQueue.main.async {
					print("Succes request for \(timeRange)")
                    self.nft = decodedResponse
				}
            }
        } catch let jsonError as NSError {
			print("JSON decode failed: \(jsonError.localizedDescription)")
		} catch {
			print("Error occured")
		}
    }
}

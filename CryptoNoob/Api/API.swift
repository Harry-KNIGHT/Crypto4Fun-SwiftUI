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
                    self.prices = decodedResponse.prices
                }
            }
        } catch {
            print("Invalid url chart request")
        }
    }

    @Published public var articles = [ArticleModel]()
    @Published public var nft = [NFTModel]()

	func fetchArticle() async {
		let url = "https://newsapi.org/v2/everything?q=crypto&from=2022-06-04&sortBy=publishedAt&apiKey=89ffff8dd6bf4abcbb4af01a08334cda"

		guard let url = URL(string: url) else {
			print("Bad article url")
			return
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)

			if let decodedResponse = try? JSONDecoder().decode([ArticleModel].self, from: data) {
				DispatchQueue.main.async {
					self.articles = decodedResponse
				}
			}
		} catch {
			print("Incalid url request")
		}
		print("End")
	}
    func fetchNFT() async {
        let url = "https://api.cryptoslam.io/v1/collections/top-100?timeRange=week"

        guard let url = URL(string: url) else {
            print("Invalid NFT url")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([NFTModel].self, from: data) {
                DispatchQueue.main.async {
                    self.nft = decodedResponse
                }
            }
        } catch {
            print("Invalid NFT request")
        }
    }
}

//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation

class ApiCall: ObservableObject {
    @Published public var datas = [Data]()
    @Published public var timeRemaining = 30
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Published public var prices = [[Double]]()
    
    var averagePrice: Double {
        let valueArray = prices.map { $0[1] }
        let sum = valueArray.reduce(0, +)


        return sum / Double(valueArray.count)
    }

    func fetchData() async {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1&sparkline=false&price_change_percentage=%271h%2C%2024h%2C%207d"

        guard let url = URL(string: url) else {
            print("Invalid url")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([Data].self, from: data) {
                DispatchQueue.main.async {
                    self.datas = decodedResponse
                }
            }
        } catch {
            print("Invalid request")
        }
    }

    func fetchChart() async {
        let url = "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1300&interval=daily"

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

        }catch {
            print("Invalid url chart request")
        }
    }
}

struct CurrencyChartResponse: Codable {
    let prices, marketCaps, totalVolumes: [[Double]]

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(miliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(miliseconds) / 1000)
    }
}

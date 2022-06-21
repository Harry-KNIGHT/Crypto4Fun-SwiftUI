//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation

@MainActor class ApiCall: ObservableObject {
    @Published public var datas = [Data]()
    @Published public var timeRemaining = 10
    public let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    @Published public var prices = [[Double]]()

    var averagePrice: Double {
        let valueArray = prices.map { $0[1] }
        let sum = valueArray.reduce(0, +)


        return sum / Double(valueArray.count)
    }

    @Published public var timeToShow: TimeToShow = .monthly

    enum TimeToShow: String, CaseIterable, Identifiable {
        case yearly = "365"
        case daily = "1"
        case monthly = "31"
        case max = "10_000"
        var id: Self { self }
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

    func fetchDataTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }else {
            Task {
                await fetchData()
                timeRemaining += 10
                print("Data fetched")
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

        }catch {
            print("Invalid url chart request")
        }
    }
}




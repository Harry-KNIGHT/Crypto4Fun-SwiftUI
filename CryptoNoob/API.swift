//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation

class ApiCall: ObservableObject {
    @Published public var datas = [Data]()

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
}

//
//  CryptoModel.swift
//  MyWallet
//
//  Created by Elliot Knight on 12/06/2022.
//

import Foundation
/*
 Documentation: https://docs.bitfine.com/reference/rest-public-tickers
 */
struct Data: Codable, Hashable {
    let id, name: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24h: Float

    enum CodingKeys: String, CodingKey {
        case id, name
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f") : String(self)
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

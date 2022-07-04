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

struct CryptoCurrencyModel: Codable, Hashable {
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

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
struct Data: Codable {
    let id, name: String
    let image: String
    let currentPrice: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case image
        case currentPrice = "current_price"
    }
}

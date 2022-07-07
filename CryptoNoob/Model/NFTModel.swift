//
//  NFTModel.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 06/07/2022.
//

import Foundation

// MARK: - NFTResponseElement
struct NFTModel: Codable, Identifiable {
    let id = UUID()
    let rank: Int
    let iconURL: String?
    let contractName, productPath: String
    let baseCurrency: BaseCurrency
    let isSalesOnly: Bool
    let value, valueUSD: Double
    let platform, buyers, sellers, owners: Int
    let transactions: Int
    let changeInValueUSD: Double?
    let previousValue, previousValueUSD: Double
    let isSlamLandDisabled: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case rank
        case iconURL = "iconUrl"
        case contractName
        case productPath, baseCurrency, isSalesOnly, value, valueUSD, platform, buyers, sellers, owners, transactions, changeInValueUSD, previousValue, previousValueUSD, isSlamLandDisabled
    }
}

enum BaseCurrency: String, Codable {
    case eth = "ETH"
    case flow = "Flow"
    case sol = "SOL"
    case usd = "USD"
}

typealias NFTResponse = [NFTModel]
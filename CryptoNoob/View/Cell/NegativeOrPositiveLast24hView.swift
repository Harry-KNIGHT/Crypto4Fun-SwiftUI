//
//  NegativeOrPositiveLast24hView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI

struct NegativeOrPositiveLast24hView: View {
    var data: Data
    var font: Font = .headline
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: data.priceChangePercentage24h < 0 ? "chevron.down" : "chevron.up")
            Text("\(String(format: "%.2f", data.priceChangePercentage24h))% ")
        }
        .foregroundColor(data.priceChangePercentage24h < 0 ? .red : .green)
        .font(font)
    }
}

struct NegativeOrPositiveLast24hView_Previews: PreviewProvider {
    static var previews: some View {
        NegativeOrPositiveLast24hView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
    }
}

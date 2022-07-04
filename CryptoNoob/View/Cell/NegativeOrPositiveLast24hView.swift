//
//  NegativeOrPositiveLast24hView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI

struct NegativeOrPositiveTimeView: View {
	var cryptoCurrency: CryptoCurrencyModel
    var font: Font = .headline
	@EnvironmentObject var apiCall: ApiCall
    var body: some View {
        HStack(spacing: 5) {
			Image(systemName: apiCall.pricePercentageValue < 0 ? "chevron.down" : "chevron.up")
			Text("\(String(format: "%.2f", apiCall.pricePercentageValue))% ")
        }
		.foregroundColor(apiCall.pricePercentageValue < 0 ? .red : .green)
        .font(font)
    }
}

struct NegativeOrPositiveLast24hView_Previews: PreviewProvider {
    static var previews: some View {
        NegativeOrPositiveTimeView(cryptoCurrency: CryptoCurrencyModel(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
			.environmentObject(ApiCall())
    }
}

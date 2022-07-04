//
//  CurrencyPriceView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI

struct CurrencyPriceView: View {
	var cryptoCurrency: CryptoCurrencyModel
    var body: some View {
        Text("$" + String(cryptoCurrency.currentPrice))
            .foregroundColor(.primary)
            .font(.largeTitle.bold())
    }
}

struct CurrencyPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPriceView(cryptoCurrency: CryptoCurrencyModel(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
    }
}

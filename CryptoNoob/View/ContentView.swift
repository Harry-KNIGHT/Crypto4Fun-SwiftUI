//
//  ContentView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(cryptoCurrency: CryptoCurrencyModel(
            id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

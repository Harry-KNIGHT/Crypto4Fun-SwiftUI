//
//  AsyncImageView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct AsyncImageView: View {
    let cryptoCurrency: CryptoCurrencyModel
    var width: CGFloat = 150
    var height: CGFloat = 150
    @State private var isLoading = false

    var body: some View {
        AsyncImage(url: URL(string: cryptoCurrency.image)) { image in
            image
                .resizable()
                .scaledToFit()
        }placeholder: {
				ProgressView()
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(cryptoCurrency: CryptoCurrencyModel(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
    }
}

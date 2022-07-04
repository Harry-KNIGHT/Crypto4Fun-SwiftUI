//
//  FavoriteDetailButtonView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI

struct FavoriteDetailButtonView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
	var cryptoCurrency: CryptoCurrencyModel
    var body: some View {
        Button(action: {
            favoriteVM.addOrRemoveFavorite(item: cryptoCurrency)
        }, label: {
            Label("Favorite", systemImage: favoriteVM.favoriteCryptos.contains(cryptoCurrency) ? "heart.fill" : "heart")
                .foregroundColor(.primary)
                .font(.title3)
        })
        Text("OK")
    }
}

struct FavoriteDetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
		FavoriteDetailButtonView(cryptoCurrency: CryptoCurrencyModel(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
            .environmentObject(FavoriteViewModel())
    }
}

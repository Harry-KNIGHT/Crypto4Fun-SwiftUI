//
//  FavoriteDetailButtonView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI
import Crypto4FunKit

struct FavoriteDetailButtonView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
	var cryptoCurrency: CryptoCurrencyModel
    var body: some View {
        Button(action: {
            favoriteVM.addOrRemoveFavorite(item: cryptoCurrency)
			favoriteVM.save()
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
		FavoriteDetailButtonView(cryptoCurrency: .cryptoSample)
            .environmentObject(FavoriteViewModel())
    }
}

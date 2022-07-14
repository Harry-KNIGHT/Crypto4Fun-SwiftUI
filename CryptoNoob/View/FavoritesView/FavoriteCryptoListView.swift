//
//  FavoriteListView.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 18/06/2022.
//

import SwiftUI

struct FavoriteCryptoListView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel

    var body: some View {
            if !favoriteVM.favoriteCryptos.isEmpty {
				List {
					ForEach(favoriteVM.favoriteCryptos, id: \.id) { cryptoCurrency in
						NavigationLink(destination: CurrencyChartView(cryptoCurrency: cryptoCurrency)) {
							CryptoListRowCellView(cryptoCurrency: cryptoCurrency)
						}
					}.onDelete(perform: favoriteVM.deleteFavorite)
				}
            } else {
				EmptyView(text: "No favorite Crypto", sfSymbol: "xmark.seal.fill")
				Spacer()
            }
    }
}

struct FavoriteCryptoListView_Previews: PreviewProvider {
    static var previews: some View {
		FavoriteCryptoListView()
            .environmentObject(FavoriteViewModel())
    }
}

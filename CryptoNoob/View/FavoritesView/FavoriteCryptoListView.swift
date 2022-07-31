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
				ScrollView(.vertical, showsIndicators: false) {
					ForEach(favoriteVM.favoriteCryptos, id: \.id) { crypto in
							NavigationLink(destination: CurrencyChartView(cryptoCurrency: crypto)) {
								LazyVStack(alignment: .leading) {
									CryptoListRowCellView(cryptoCurrency: crypto)
								}
								.padding(10)
								.background(.regularMaterial)
								.cornerRadius(10)
							}
					}
					.onDelete(perform: favoriteVM.deleteFavorite)
					.padding(.horizontal)
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

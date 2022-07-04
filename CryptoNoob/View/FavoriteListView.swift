//
//  FavoriteListView.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 18/06/2022.
//

import SwiftUI

struct FavoriteListView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel

    var body: some View {
        NavigationView {
            if !favoriteVM.favoriteCryptos.isEmpty {
                List(favoriteVM.favoriteCryptos, id: \.id) { cryptoCurrency in
                    NavigationLink(destination: CurrencyChartView(cryptoCurrency: cryptoCurrency)) {
						ListRowCellView(cryptoCurrency: cryptoCurrency)
                    }
                }.navigationBarTitle("Favoris")
            } else {
                EmptyView()
            }
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
            .environmentObject(FavoriteViewModel())
    }
}

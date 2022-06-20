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
                List(favoriteVM.favoriteCryptos, id: \.id) { item in
                    NavigationLink(destination: CurrencyChartView(data: item)) {
                        HStack {
                            AsyncImageView(data: item, width: 50, height: 50)

                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                HStack(alignment: .center, spacing: 1) {
                                    Text("$")
                                        .bold()
                                    Text(String(item.currentPrice.formatted()))
                                    Spacer()

                                }
                            }
                            Text("\(String(format: "%.2f", item.priceChangePercentage24h))% ")
                                .foregroundColor(item.priceChangePercentage24h < 0 ? Color.red : Color.green)
                        }
                    }.navigationBarTitle("Favoris")
                }
            }else {
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

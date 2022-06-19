//
//  DetailView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct DetailView: View {
    let data: Data
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            AsyncImageView(data: data)
                .padding(20)

            HStack(spacing: 1) {
                Text("$")
                Text(String(data.currentPrice.formatted()))
            }
            .foregroundColor(data.priceChangePercentage24h < 0 ? Color.red : Color.green)
            .font(.largeTitle.bold())
            .padding()
            .background(.regularMaterial)
            .cornerRadius(10)

            NegativeOrPositiveLast24hView(data: data)
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(id: data.id, placement: .navigationBarTrailing, showsByDefault: true) {
                Button(action: {
                    favoriteVM.addOrRemoveFavorite(item: data)
                }, label: {
                    Label("Ajout aux Favoris", systemImage: favoriteVM.favoriteCryptos.contains(data) ? "heart.fill" : "heart")
                        .font(.title3)
                })

            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FavoriteViewModel())
    }
}

struct NegativeOrPositiveLast24hView: View {
    var data: Data
    var font: Font = .headline
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: data.priceChangePercentage24h < 0 ? "chevron.down" : "chevron.up")
            Text("\(String(format: "%.2f", data.priceChangePercentage24h))% ")
        }
        .foregroundColor(data.priceChangePercentage24h < 0 ? .red : .green)
        .font(font)
    }
}

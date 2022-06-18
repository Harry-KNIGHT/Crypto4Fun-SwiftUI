//
//  DetailView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct DetailView: View {
    let data: Data
    @EnvironmentObject var apiCall: ApiCall
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    var body: some View {
        VStack {
            Spacer()
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
        Spacer()

            Button(action: {
                Task {
                    await apiCall.fetchData()
                    print(data.currentPrice)
                }
            }, label: {
                Label("Actualiser", systemImage: "arrow.triangle.2.circlepath")


            })
            .font(.title.bold())
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tint(Color.blue)


            Spacer()
        }
        .toolbar(content: {
                    ToolbarItem(id: data.id, placement: .navigationBarTrailing, showsByDefault: true) {
                        Button(action: {
                            favoriteVM.addOrRemoveFavorite(item: data)
                        }, label: {
                            Label("Ajout aux Favoris", systemImage: favoriteVM.favoriteCryptos.contains(data) ? "heart.fill" : "heart")
                        })

                    }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(ApiCall())
            .environmentObject(FavoriteViewModel())
    }
}

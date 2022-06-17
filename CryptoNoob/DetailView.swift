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
    var body: some View {
        AsyncImage(url: URL(string: data.image)) { image in
            image
                .resizable()
                .scaledToFit()
        }placeholder: {
            Color.secondary
        }
        .frame(width: 150, height: 150, alignment: .center)
        .padding()
        Text(String(data.currentPrice))
            .font(.largeTitle.bold())
            .padding()
            .background(.regularMaterial)
            .cornerRadius(10)

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45))
    }
}

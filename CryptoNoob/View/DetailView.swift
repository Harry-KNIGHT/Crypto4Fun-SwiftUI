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
        VStack {
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
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(ApiCall())
    }
}

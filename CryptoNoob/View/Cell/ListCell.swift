//
//  ListCell.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 18/06/2022.
//

import SwiftUI

struct ListCell: View {
    var item: Data
    @EnvironmentObject var apiCall: ApiCall

    var body: some View {
        List(apiCall.datas, id: \.id) { item in
            NavigationLink(destination: DetailView(data: item)) {
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
            }
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(item: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))            .environmentObject(ApiCall())

    }
}

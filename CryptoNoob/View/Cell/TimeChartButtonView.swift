//
//  TimeChartButtonView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 20/06/2022.
//

import SwiftUI

struct TimeChartButtonView: View {
    @EnvironmentObject var chartApiResponse: ApiCall
    var data: Data

    var body: some View {
      HStack {
            Spacer()
            Button(action: {
                Task {
                    await chartApiResponse.fetchChart(data, timeChartShow: ApiCall.TimeToShow.daily)
                }
            }, label: {
                Text("Day")
            })
            Spacer()

            Button(action: {
                Task {
                    await chartApiResponse.fetchChart(data, timeChartShow: ApiCall.TimeToShow.monthly)
                }
            }, label: {
                Text("month")
            })
            Spacer()

            Button(action: {
                Task {
                    await chartApiResponse.fetchChart(data, timeChartShow: ApiCall.TimeToShow.yearly)
                }
            }, label: {
                Text("year")
            })
            Spacer()

            Button(action: {
                Task {
                    await chartApiResponse.fetchChart(data, timeChartShow: ApiCall.TimeToShow.max)
                }
            }, label: {
                Text("Max")
            })
            Spacer()

        }
    }
}

struct TimeChartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TimeChartButtonView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(ApiCall())
    }
}

//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts

struct CurrencyChartView: View {
    @EnvironmentObject var chartApiResponse: ApiCall
    @State private var showAveragePrice: Bool = true
    @State private var timeToShow = "D"
    var timesToShow = ["M", "D", "Y"]
    var data: Data

    var body: some View {
        VStack {

            Chart {
                ForEach(chartApiResponse.prices, id: \.self) {
                    LineMark(x: .value("Date", Date(miliseconds: Int64($0[0]))),
                             y: .value("Price", $0[1])
                    ).foregroundStyle(data.priceChangePercentage24h < 0 ? .red : .green)
                }

                if showAveragePrice {
                    RuleMark(
                        y: .value("Threshold", chartApiResponse.averagePrice)
                    ).foregroundStyle(.primary)
                }
            }
            .task {
                await chartApiResponse.fetchChart(data.id)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bitcoin")
            VStack(spacing: 10) {
                Toggle("Average price", isOn: $showAveragePrice)
                Picker("Chose time", selection: $timeToShow) {
                    ForEach(timesToShow, id: \.self) {
                        Text($0)
                    }

                }.pickerStyle(.segmented)
            }.padding()
        }.padding(.vertical)
    }
}

struct CurrencyChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyChartView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FavoriteViewModel())
            .environmentObject(ApiCall())
    }
}

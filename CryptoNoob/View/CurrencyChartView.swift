//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts

struct CurrencyChartView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var chartApiResponse: ApiCall
    @State private var showAveragePrice: Bool = false
    var data: Data

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                CurrencyPriceView(data: data)
                    NegativeOrPositiveLast24hView(data: data, font: .body)
            }
            .padding(.horizontal)
            Chart {
                ForEach(chartApiResponse.prices, id: \.self) {
                    LineMark(x: .value("Date", Date(miliseconds: Int64($0[0]))),
                             y: .value("Price", $0[1])
                    )

                    .foregroundStyle(data.priceChangePercentage24h < 0 ? .red : .green)

                }

                if showAveragePrice {
                    RuleMark(
                        y: .value("Threshold", chartApiResponse.averagePrice)
                    ).foregroundStyle(.primary)
                }

            }.task {
                await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.monthly)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(data.name)
            .navigationBarItems(trailing: FavoriteDetailButtonView(data: data))

            ToggleAveragePriceView(showAveragePrice: $showAveragePrice)
            Divider()
                .padding(.horizontal, 50)
            HStack {
                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.monthly)
                        print("Monthly pushed")
                    }
                }, label: {
                    Text("MONTH")
                })
                .modifier(ButtonTimeSelected())

                Spacer()

                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.yearly)
                        print("Yearly pushed")
                    }
                }, label: {
                    Text("YEAR")
                })
                .modifier(ButtonTimeSelected())

                Spacer()

                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.max)
                    }
                }, label: {
                    Text("MAX")
                })
                .modifier(ButtonTimeSelected())
            }.padding()
        }
    }
}



struct CurrencyChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyChartView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FavoriteViewModel())
            .environmentObject(ApiCall())
    }
}
struct ToggleAveragePriceView: View {
    @Binding var showAveragePrice: Bool
    var body: some View {
        Toggle("Moyenne", isOn: $showAveragePrice)
            .tint(.primary)
            .padding(.horizontal)
            .padding(.top)
    }
}

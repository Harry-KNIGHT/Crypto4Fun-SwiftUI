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
    @Environment(\.colorScheme) private var colorScheme
    var data: Data

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {

                CurrencyPriceView(data: data)
                    NegativeOrPositiveLast24hView(data: data, font: .body)

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
                    )
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            .frame(minHeight: 350, maxHeight: 450)
            .padding(5)
            .task {
                await chartApiResponse.fetchChart(data.id, timeChartShow: TimeToShow.monthly)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(data.name)
            .navigationBarItems(trailing: FavoriteDetailButtonView(data: data))

            ToggleAveragePriceView(showAveragePrice: $showAveragePrice)
            Divider()
                    .padding(.vertical, 10)
                HStack {
                    Button(action: {
                        Task {
                            await chartApiResponse.fetchChart(data.id, timeChartShow: TimeToShow.monthly)
                            print("Monthly pushed")
                        }
                    }, label: {
                        Text("MONTH")
                    })

                    Spacer()

                    Button(action: {
                        Task {
                            await chartApiResponse.fetchChart(data.id, timeChartShow: TimeToShow.yearly)
                            print("Yearly pushed")
                        }
                    }, label: {
                        Text("YEAR")
                    })

                    Spacer()

                    Button(action: {
                        Task {
                            await chartApiResponse.fetchChart(data.id, timeChartShow: TimeToShow.max)
                        }
                    }, label: {
                        Text("MAX")
                    })

                }       .modifier(ButtonTimeSelected())
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
            .padding(.top)
    }
}

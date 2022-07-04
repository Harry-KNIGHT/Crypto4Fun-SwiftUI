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
	var cryptoCurrency: CryptoCurrencyModel
    @State private var tagSelected = 2

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Group {
				CurrencyPriceView(cryptoCurrency: cryptoCurrency)
				NegativeOrPositiveTimeView(cryptoCurrency: cryptoCurrency)
                }.padding(.horizontal)

                Chart {
                    ForEach(chartApiResponse.prices, id: \.self) {
                        LineMark(
                            x: .value("Date", Date(miliseconds: Int64($0[0]))),
                            y: .value("Price", $0[1])
                        )
						.foregroundStyle(chartApiResponse.pricePercentageValue < 0 ? .red : .green)
                    }

                    if showAveragePrice {
                        RuleMark(
                            y: .value("Average price", chartApiResponse.averagePrice)
                        )
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 400, maxHeight: 550)
                .padding(.trailing, 5)
                .task {
                    await chartApiResponse.fetchChart(cryptoCurrency.id, timeChartShow: TimeToShow.yearly)
                }
                .onChange(of: tagSelected, perform: { _ in
                    switch tagSelected {
                    case 0:
                        Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, timeChartShow: TimeToShow.weekly)
                        }
                    case 1:
                        Task {
                            await chartApiResponse.fetchChart(cryptoCurrency.id, timeChartShow: TimeToShow.monthly)
                        }
                    case 2:
                        Task {
                            await chartApiResponse.fetchChart(cryptoCurrency.id, timeChartShow: TimeToShow.yearly)
                        }
                    default:
                        Task {
                            await chartApiResponse.fetchChart(cryptoCurrency.id, timeChartShow: TimeToShow.max)
                        }
                    }
                })
                Group {
                    ToggleAveragePriceView(showAveragePrice: $showAveragePrice)

                    Divider()

                    Picker("Select time value", selection: $tagSelected) {
                        Text("Week").tag(0)
                        Text("Month").tag(1)
                        Text("Year").tag(2)
                        Text("Max").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(cryptoCurrency.name)
		.navigationBarItems(trailing: FavoriteDetailButtonView(cryptoCurrency: cryptoCurrency))
    }
}

struct CurrencyChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyChartView(cryptoCurrency: CryptoCurrencyModel(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
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

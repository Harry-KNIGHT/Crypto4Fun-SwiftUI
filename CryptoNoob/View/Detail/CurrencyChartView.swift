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
    @EnvironmentObject var chartApiResponse: FetchChartApi
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
				.chartYScale(domain: .automatic(includesZero: false))
				.frame(maxWidth: .infinity, minHeight: 500, maxHeight: 700)
                .padding(.trailing, 5)
				.task {
                    await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.month.rawValue) ?? 0))
                }
                .onChange(of: tagSelected, perform: { _ in
                    switch tagSelected {
					case 0:
						Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.day.rawValue) ?? 0))
						}
                    case 1:
                        Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.week.rawValue) ?? 0))
                        }
                    case 2:
                        Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.month.rawValue) ?? 0))
                        }
                    case 3:
                        Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.year.rawValue) ?? 0))
                        }
                    default:
                        Task {
							await chartApiResponse.fetchChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.max.rawValue) ?? 0))
                        }
                    }
                })
                Group {
                    Picker("Select time value", selection: $tagSelected) {
						Text("Day").tag(0)
                        Text("Week").tag(1)
                        Text("Month").tag(2)
                        Text("Year").tag(3)
                        Text("Max").tag(4)
					}
                    .pickerStyle(.segmented)
					.padding(.vertical)

					Divider()
						.padding(.horizontal,40)
					
					ToggleAveragePriceView(showAveragePrice: $showAveragePrice)
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
		NavigationStack {
			CurrencyChartView(cryptoCurrency: CryptoCurrencyModel(
				id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
			.environmentObject(FavoriteViewModel())
			.environmentObject(FetchChartApi())
		}
    }
}

struct ToggleAveragePriceView: View {
    @Binding var showAveragePrice: Bool
    var body: some View {
        Toggle("Average", isOn: $showAveragePrice)
            .tint(.primary)
            .padding(.top)
    }
}

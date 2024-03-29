//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts
import Crypto4FunKit

struct CurrencyChartView: View {
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@EnvironmentObject var fetchChart: FetchChartViewModel
	@State private var showAveragePrice: Bool = false
	@Environment(\.colorScheme) private var colorScheme
	var cryptoCurrency: CryptoCurrencyModel

	@State private var epochTimeToShowSelected: EpochUnixTime = .month

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading) {
				Group {
					CurrencyPriceView(cryptoCurrency: cryptoCurrency)
					NegativeOrPositiveTimeView(cryptoCurrency: cryptoCurrency)
				}.padding(.horizontal)

				ChartView(showAveragePrice: $showAveragePrice)
				
				.onAppear {
						 fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - EpochUnixTime.month.rawValue)
				}
				.onChange(of: epochTimeToShowSelected, perform: { _ in
					 fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - epochTimeToShowSelected.rawValue)
				})
				Picker("Select time value", selection: $epochTimeToShowSelected) {
					ForEach(EpochUnixTime.allCases, id: \.self) { value in
						Text(String(value.name))
							.tag(value)
					}
				}
				.pickerStyle(.segmented)
				.padding([.vertical, .horizontal])

				Divider()
					.padding(.horizontal,40)
				ToggleAveragePriceView(showAveragePrice: $showAveragePrice)
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
			CurrencyChartView(cryptoCurrency: .cryptoSample)
				.environmentObject(FavoriteViewModel())
				.environmentObject(FetchChartViewModel())
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

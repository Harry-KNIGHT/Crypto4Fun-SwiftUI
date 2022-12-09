//
//  WatchCryptoDetailView.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI
import Crypto4FunKit
import Charts

struct WatchCryptoDetailView: View {
	let crypto: CryptoCurrencyModel
	@EnvironmentObject var chartVM: FetchChartViewModel

	var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(crypto.name.capitalized)
				.font(.body)
				.fontWeight(.medium)
			Text("$\(crypto.currentPrice.twoDigitDouble)")
				.font(.title2)
				.foregroundColor(crypto.priceChangePercentage24h.positiveOrNegativeColor)
			Text(
				"\(crypto.priceChangePercentage24h.plusOrMinusIndicator)\(crypto.priceChangePercentage24h.twoDigitFloat)%"
			)
			.font(.callout)
			.foregroundColor(crypto.priceChangePercentage24h.positiveOrNegativeColor)

			Spacer()

			ChartView(
				showAveragePrice: .constant(false),
				minHeight: 65,
				maxHeight: 80,
				hasTraillingPadding: false
			)
		}
		.fontDesign(.rounded)
		.onAppear {
			chartVM.getChart(crypto.id, from: Date().timeIntervalSince1970 - EpochUnixTime.day.rawValue)
		}
		.onDisappear {
			chartVM.prices = [[Double]]()
		}
	}
}

struct WatchCryptoDetailView_Previews: PreviewProvider {
	static var previews: some View {
		WatchCryptoDetailView(crypto: .cryptoSample)
			.environmentObject(FetchChartViewModel())
	}
}

//
//  NegativeOrPositiveLast24hView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI
import Crypto4FunKit

struct NegativeOrPositiveTimeView: View {
	var cryptoCurrency: CryptoCurrencyModel
    var font: Font = .headline
	@EnvironmentObject var fetchChart: FetchChartViewModel
    var body: some View {
        HStack(spacing: 5) {
			Image(systemName: fetchChart.pricePercentageValue < 0 ? "chevron.down" : "chevron.up")
			Text("\(String(format: "%.2f", fetchChart.pricePercentageValue))% ")
        }
		.foregroundColor(fetchChart.pricePercentageValue < 0 ? .red : .green)
        .font(font)
    }
}

struct NegativeOrPositiveLast24hView_Previews: PreviewProvider {
    static var previews: some View {
		NegativeOrPositiveTimeView(cryptoCurrency: .cryptoSample)
			.environmentObject(FetchChartViewModel())
    }
}

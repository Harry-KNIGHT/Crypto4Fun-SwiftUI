//
//  ListRowCellView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 09/07/2022.
//

import SwiftUI

struct ListRowCellView: View {
	var cryptoCurrency: CryptoCurrencyModel
	var body: some View {
		HStack {
			AsyncImageView(cryptoCurrency: cryptoCurrency, width: 50, height: 50)
			VStack(alignment: .leading) {
				Text(cryptoCurrency.name)
					.font(.headline)
				Text("$" + String(cryptoCurrency.currentPrice.formatted()))
					.font(.body)
			}
			Spacer()
			HStack(spacing: 5) {
				Image(systemName: cryptoCurrency.priceChangePercentage24h < 0 ? "chevron.down" : "chevron.up")
				Text("\(String(format: "%.2f", cryptoCurrency.priceChangePercentage24h))% ")
			}
			.foregroundColor(cryptoCurrency.priceChangePercentage24h < 0 ? .red : .green)
			.font(.body)
		}
	}
}

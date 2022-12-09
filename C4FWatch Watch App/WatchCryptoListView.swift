//
//  WatchCryptoListView.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI
import Crypto4FunKit

struct WatchCryptoListView: View {
	@State private var cryptos = [CryptoCurrencyModel]()
	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach(cryptos, id: \.id) { crypto in
						VStack(alignment: .leading, spacing: 2) {
							HStack(spacing: 0) {
								Text(crypto.name)
									.font(.caption)
									.lineLimit(1)
								Spacer()
								Text(crypto.priceChangePercentage24h > 0 ? "+" : "")
								Text("\(String(format: "%.2f", crypto.priceChangePercentage24h)) %")
									.font(.caption)

							}
							Text(String(format: "$%.2f", crypto.currentPrice))
								.font(.title3)
						}
						.listItemTint(crypto.priceChangePercentage24h > 0 ? .green : .red	)
					}
				}
			}
			.navigationTitle("C4F")
		}
		.onAppear {
			Task {
				do {
					let allCrypto = try await CryptoApi.fetchCryptoCurrency()
					cryptos = allCrypto
				} catch {
					throw error
				}
			}
		}
	}
}

struct WatchCryptoListView_Previews: PreviewProvider {
	static var previews: some View {
		WatchCryptoListView()
	}
}

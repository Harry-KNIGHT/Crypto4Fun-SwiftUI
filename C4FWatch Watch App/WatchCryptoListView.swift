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
						NavigationLink(destination: WatchCryptoDetailView(crypto: crypto)) {
							VStack(alignment: .leading, spacing: 2) {
								HStack(spacing: 0) {
									Text(crypto.name)
										.font(.caption)
										.lineLimit(1)
									Spacer()
									Text(crypto.priceChangePercentage24h.plusOrMinusIndicator)
									Text("\(crypto.priceChangePercentage24h.twoDigitFloat) %")
										.font(.caption)
								}
								Text("$\(crypto.currentPrice.twoDigitDouble)")
									.font(.title3)
							}
						}
						.listItemTint(crypto.priceChangePercentage24h.positiveOrNegativeColor)
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

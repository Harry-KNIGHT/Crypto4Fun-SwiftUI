//
//  WatchCryptoListView.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI
import Crypto4FunKit

struct WatchCryptoListView: View {

	@EnvironmentObject var cryptoVM: CryptoViewModel
	var body: some View {
		NavigationView {
			VStack {
				List {
					ForEach(cryptoVM.cryptoCurrencies, id: \.id) { crypto in
						NavigationLink(destination: WatchCryptoDetailView(crypto: crypto)) {
							VStack(alignment: .leading) {
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
									.font(.title2)
							}
						}
						.listItemTint(crypto.priceChangePercentage24h.positiveOrNegativeColor)
					}
				}
			}
			.navigationTitle("C4F")
		}
		.onAppear {
			cryptoVM.getCryptos()
		}
	}
}

struct WatchCryptoListView_Previews: PreviewProvider {
	static var previews: some View {
		WatchCryptoListView()
			.environmentObject(CryptoViewModel())
	}
}

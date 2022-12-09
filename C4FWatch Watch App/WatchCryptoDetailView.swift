//
//  WatchCryptoDetailView.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI
import Crypto4FunKit

struct WatchCryptoDetailView: View {
	let crypto: CryptoCurrencyModel
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				AsyncImageView(cryptoCurrency: crypto, width: 50, height: 50)

				Spacer()
				Text("\(crypto.priceChangePercentage24h.twoDigitFloat)%")
					.font(.callout)
					.foregroundColor(crypto.priceChangePercentage24h > 0 ? .green : .red)

			}
			Spacer()
			Text(crypto.name.capitalized)
				.font(.title2)
				.fontWeight(.medium)
			Spacer()
			Text("$\(crypto.currentPrice.twoDigitDouble)")
				.font(.title)
				.foregroundColor(crypto.priceChangePercentage24h > 0 ? .green : .red	)

			Spacer()
		}
		.fontDesign(.rounded)
	}
}

struct WatchCryptoDetailView_Previews: PreviewProvider {
	static var previews: some View {
		WatchCryptoDetailView(crypto: .cryptoSample)
	}
}

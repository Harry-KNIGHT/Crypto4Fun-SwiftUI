//
//  WidgetCryptoListRowCell.swift
//  C4FWatch Watch App
//
//  Created by Elliot Knight on 10/12/2022.
//

import SwiftUI
import Crypto4FunKit

struct WidgetCryptoListRowCell: View {
	let crypto: CryptoCurrencyModel
    var body: some View {
		VStack(alignment: .leading) {
			HStack(spacing: 0) {
				Text(crypto.name)
					.font(.caption)
					.lineLimit(1)
					.accessibilityLabel(crypto.name)
				Spacer()
				Text(crypto.priceChangePercentage24h.plusOrMinusIndicator)
					.accessibilityHidden(true)

				Text("\(crypto.priceChangePercentage24h.twoDigitFloat) %")
					.font(.caption)
					.accessibilityHidden(true)
			}
			Text("$\(crypto.currentPrice.twoDigitDouble)")
				.font(.title2)
				.accessibilityValue(crypto.currentPrice.description)
				.accessibilityLabel("Crypto's price in dollar.")

		}
    }
}

struct WidgetCryptoListRowCell_Previews: PreviewProvider {
    static var previews: some View {
		WidgetCryptoListRowCell(crypto: .cryptoSample)
    }
}

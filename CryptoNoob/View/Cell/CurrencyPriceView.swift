//
//  CurrencyPriceView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 21/06/2022.
//

import SwiftUI
import Crypto4FunKit

struct CurrencyPriceView: View {
	var cryptoCurrency: CryptoCurrencyModel
    var body: some View {
        Text("$" + String(cryptoCurrency.currentPrice))
            .foregroundColor(.primary)
            .font(.largeTitle.bold())
    }
}

struct CurrencyPriceView_Previews: PreviewProvider {
    static var previews: some View {
		CurrencyPriceView(cryptoCurrency: .cryptoSample)
    }
}

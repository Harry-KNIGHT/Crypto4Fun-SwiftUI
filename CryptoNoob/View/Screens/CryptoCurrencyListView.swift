//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI
import Crypto4FunKit

struct CryptoCurrencyListView: View {
	@EnvironmentObject var crypto: CryptoViewModel

	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				ForEach(crypto.cryptoCurrencies, id: \.id) { crypto in
					NavigationLink(destination: CurrencyChartView(cryptoCurrency: crypto)) {
						LazyVStack(alignment: .leading) {
							CryptoListRowCellView(cryptoCurrency: crypto)
						}
						.padding(10)
						.background(.regularMaterial)
						.cornerRadius(10)
						.shadow(color: .secondary, radius: 1.5)
					}
				}
				.padding(.horizontal)
				.padding(.top)
			}
			.navigationTitle("C4F")
		}
		.onAppear {
			crypto.getCryptos()
		}
		.onReceive(crypto.timer) { _ in
			crypto.fetchDataTimer()
		}
	}
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
	static var previews: some View {
		CryptoCurrencyListView()
			.environmentObject(CryptoViewModel())
	}
}

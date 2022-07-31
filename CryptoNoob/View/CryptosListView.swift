//
//  CryptosListView.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import SwiftUI

struct CryptosListView: View {
	@EnvironmentObject var cryptos: CryptoApiCall
	@EnvironmentObject var fetchNft: FetchNftApi


	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
				ForEach(cryptos.cryptoCurrencies, id: \.id) { crypto in
					NavigationLink(destination: CurrencyChartView(cryptoCurrency: crypto)) {
						LazyVStack(alignment: .leading) {
							CryptoListRowCellView(cryptoCurrency: crypto)
						}
						.padding(10)
						.background(.regularMaterial)
						.cornerRadius(10)
					}
				}
				.padding(.horizontal)

			}
			.task {
				await cryptos.fetchCryptoCurrency()
			}
			.onReceive(cryptos.timer) { _ in
				cryptos.fetchDataTimer()
			}
			.onAppear {
				Task {
					await fetchNft.fetchNFT(NftTimeRange.day)
				}
			}
	}
}

struct CryptosListView_Previews: PreviewProvider {
	static var previews: some View {
		CryptosListView()
			.environmentObject(CryptoApiCall())
			.environmentObject(FetchNftApi())

	}
}

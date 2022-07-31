//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
	@EnvironmentObject var crypto: CryptoApiCall
	@EnvironmentObject var fetchNft: FetchNftApi

    var body: some View {
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
			}
			.task {
				await crypto.fetchCryptoCurrency()
			}
			.onReceive(crypto.timer) { _ in
				crypto.fetchDataTimer()
			}
			.onAppear {
				Task {
					await fetchNft.fetchNFT(NftTimeRange.day)
				}
			}
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView()
            .environmentObject(CryptoApiCall())
			.environmentObject(FetchNftApi())

    }
}

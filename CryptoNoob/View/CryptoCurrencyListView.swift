//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
	@EnvironmentObject var nft: NftApi
	@EnvironmentObject var cryptoApi: FetchCryptoCurrencyApi

    var body: some View {
		List(cryptoApi.cryptoCurrencies, id: \.self) { cryptoCurrency in
			NavigationLink(destination: CurrencyChartView(cryptoCurrency: cryptoCurrency)) {
				CryptoListRowCellView(cryptoCurrency: cryptoCurrency)
			}
		}
		.listStyle(.plain)

		.task {
            await cryptoApi.fetchCryptoCurrency()
        }
        .onReceive(cryptoApi.timer) { _ in
            cryptoApi.fetchDataTimer()
        }
		.onAppear {
			Task {
				await nft.fetchNft(NftTimeRange.day)
			}
		}
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView()
            .environmentObject(NftApi())
			.environmentObject(FetchCryptoCurrencyApi())
    }
}

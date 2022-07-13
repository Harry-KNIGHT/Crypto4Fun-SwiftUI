//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
	@EnvironmentObject var crypto: CryptoApiCall
	@EnvironmentObject var apiCall: ApiCall

    var body: some View {
		List(crypto.cryptoCurrencies, id: \.self) { cryptoCurrency in
			NavigationLink(destination: CurrencyChartView(cryptoCurrency: cryptoCurrency)) {
				CryptoListRowCellView(cryptoCurrency: cryptoCurrency)
			}
		}
		.listStyle(.plain)

		.task {
            await crypto.fetchCryptoCurrency()
        }
        .onReceive(crypto.timer) { _ in
            crypto.fetchDataTimer()
        }
		.onAppear {
			Task {
				await apiCall.fetchNFT(NftTimeRange.day)
			}
		}
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView()
            .environmentObject(CryptoApiCall())
			.environmentObject(ApiCall())
    }
}

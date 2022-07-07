//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
    @EnvironmentObject var apiCall: ApiCall

    var body: some View {
		List(apiCall.cryptoCurrencies, id: \.self) { cryptoCurrency in
			NavigationLink(destination: CurrencyChartView(cryptoCurrency: cryptoCurrency)) {
                ListRowCellView(cryptoCurrency: cryptoCurrency)
			}
		}
		.listStyle(.plain)

		.task {
            await apiCall.fetchCryptoCurrency()
        }
        .onReceive(apiCall.timer) { _ in
            apiCall.fetchDataTimer()
        }
		.onAppear {
			Task {
				await apiCall.fetchNFT()
			}
		}
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView()
            .environmentObject(ApiCall())
    }
}

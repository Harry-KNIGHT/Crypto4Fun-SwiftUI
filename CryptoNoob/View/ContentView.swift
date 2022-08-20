//
//  ContentView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject public var fetchNFT = FetchNftApi()
	@ObservedObject public var fetchChart = FetchChartApi()
	@ObservedObject public var fetchCryptoCurrency = CryptoViewModel()
	@ObservedObject public var fetchNews = FetchNewsApi()
    var body: some View {
       MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.environmentObject(FetchNftApi())
			.environmentObject(FetchChartApi())
			.environmentObject(CryptoViewModel())
			.environmentObject(FetchNewsApi())
    }
}

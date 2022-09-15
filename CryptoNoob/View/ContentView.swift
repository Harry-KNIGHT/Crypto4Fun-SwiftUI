//
//  ContentView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject public var fetchChart = FetchChartViewModel()
	@ObservedObject public var fetchCryptoCurrency = CryptoViewModel()
	@ObservedObject public var fetchNews = FetchNewsViewModel()
    var body: some View {
       MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.environmentObject(FetchChartViewModel())
			.environmentObject(CryptoViewModel())
			.environmentObject(FetchNewsViewModel())
    }
}

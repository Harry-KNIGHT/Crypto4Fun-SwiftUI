//
//  CryptoNoobApp.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

@main
struct CryptoNoobApp: App {
    @StateObject var favoriteVM = FavoriteViewModel()
    @StateObject var nftVM = FavoriteNftsViewModel()
	@StateObject var cryptoCurrencyApi = FetchCryptoCurrencyApi()
	@StateObject var cryptoCurrencyChartApi = FetchChartApi()
	@StateObject var nftApi = NftApi()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(nftApi)
                .environmentObject(favoriteVM)
                .environmentObject(nftVM)
				.environmentObject(cryptoCurrencyApi)
				.environmentObject(cryptoCurrencyChartApi)
				.environmentObject(nftApi)
        }
    }
}

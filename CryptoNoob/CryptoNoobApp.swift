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
	@StateObject var cryptoCurrencyApi = CryptoApiCall()
	@StateObject var fetchChartApi = FetchChartApi()
	@StateObject var fetchNftApi = FetchNftApi()
	@StateObject var fetchNewsApi = FetchNewsApi()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteVM)
                .environmentObject(nftVM)
				.environmentObject(cryptoCurrencyApi)
				.environmentObject(fetchChartApi)
				.environmentObject(fetchNftApi)
				.environmentObject(fetchNewsApi)
        }
    }
}

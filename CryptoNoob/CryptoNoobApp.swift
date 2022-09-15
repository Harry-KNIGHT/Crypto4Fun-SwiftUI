//
//  CryptoNoobApp.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI
import Crypto4FunKit

@main
struct CryptoNoobApp: App {
    @StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var cryptoCurrencyApi = CryptoViewModel()
	@StateObject var fetchChartApi = FetchChartViewModel()
	@StateObject var fetchNewsApi = FetchNewsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteVM)
				.environmentObject(cryptoCurrencyApi)
				.environmentObject(fetchChartApi)
				.environmentObject(fetchNewsApi)
        }
    }
}

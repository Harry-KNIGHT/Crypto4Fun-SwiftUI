//
//  CryptoNoobApp.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

@main
struct CryptoNoobApp: App {
    @StateObject var apiCall = ApiCall()
    @StateObject var favoriteVM = FavoriteViewModel()
    @StateObject var nftVM = FavoriteNftsViewModel()
	@StateObject var cryptoCurrencyApi = CryptoApiCall()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiCall)
                .environmentObject(favoriteVM)
                .environmentObject(nftVM)
				.environmentObject(cryptoCurrencyApi)
        }
    }
}

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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiCall)
        }
    }
}

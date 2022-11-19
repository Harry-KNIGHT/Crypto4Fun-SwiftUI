//
//  MainView.swift
//  MyWallet
//
//  Created by Elliot Knight on 12/06/2022.
//

import SwiftUI

struct MainView: View {
	@State private var isOn: Bool = false
	@State private var selection = 0

	var body: some View {
		NavigationStack {
			VStack {
				SelectViewPickerView(info: "Select view to show", selection: $selection)
				if selection == 0 {
					CryptoCurrencyListView()
				} else {
					NewsView()
				}
			}
			.navigationBarItems(trailing: FavoriteButtonSheetView(isOn: $isOn))
			.navigationTitle("Crypto4Fun")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.dark)
			.environmentObject(FavoriteViewModel())
			.environmentObject(CryptoViewModel())
			.environmentObject(FetchNewsViewModel())
			.environmentObject(FetchChartViewModel())
			
	}
}

struct FavoriteButtonSheetView: View {
	@Binding var isOn: Bool
	var body: some View {
		Button(action: {
			isOn.toggle()
		}, label: {
			Label("Like button", systemImage: "heart.fill")
				.font(.title3)
				.foregroundColor(.primary)
		}).sheet(isPresented: $isOn) {
			FavoritesSheetView()
		}
	}
}


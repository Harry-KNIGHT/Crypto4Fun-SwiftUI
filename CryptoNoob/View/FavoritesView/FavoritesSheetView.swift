//
//  FavoritesSheetView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 09/07/2022.
//

import SwiftUI

struct FavoritesSheetView: View {
	@State private var selectedView: Int = 0
	var body: some View {
		NavigationStack {
			VStack {
				FavoriteCryptoListView()
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Favoris")
						.font(.headline)
				}
			}
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct FavoritesSheetView_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesSheetView()
			.environmentObject(FavoriteViewModel())
	}
}

//
//  FavoriteViewModel.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 18/06/2022.
//

import Foundation

/// Favorite View Model
class FavoriteViewModel: ObservableObject {
	@Published public var favoriteCryptos: [CryptoCurrencyModel]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedData") {
			if let decoded = try? JSONDecoder().decode([CryptoCurrencyModel].self, from: data) {
				favoriteCryptos = decoded
				return
			}
		}
		// No Saved data
		favoriteCryptos = []
	}

	func save() {
		if let encoded = try? JSONEncoder().encode(favoriteCryptos) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")
		}
	}

    /// Add favorite crypto currency.
    /// - Parameter item: Add crypto currency to favoriteCryptos array.
    func addFavorite(item: CryptoCurrencyModel) {
        favoriteCryptos.append(item)
		save()
    }

    /// Delet favorite currency.
    /// - Parameter item: Delet favorite currency from index set.
    func deleteFavorite(item: IndexSet) {
        favoriteCryptos.remove(atOffsets: item)
    }

    /// Remove favorite crypto
    /// - Parameter item: Remove favorite crypto currency from id.
    func removeFavoriteCrypto(item: CryptoCurrencyModel) {
        self.favoriteCryptos.removeAll {
            $0.id == item.id
        }
    }

    /// Add or remove favorite crypto currency.
    /// - Parameter item: Add or remove crypto currency if it's on the favoriteCryptos or no.
    func addOrRemoveFavorite(item: CryptoCurrencyModel) {
        if favoriteCryptos.contains(item) {
            removeFavoriteCrypto(item: item)
        } else {
            addFavorite(item: item)
        }
    }
}

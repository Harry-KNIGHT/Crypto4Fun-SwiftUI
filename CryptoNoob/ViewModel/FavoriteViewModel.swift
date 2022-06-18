//
//  FavoriteViewModel.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 18/06/2022.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published public var favoriteCryptos = [Data]()
    
    // Ajouter un Favoris
    
    func addFavorite(item: Data) {
        favoriteCryptos.append(item)
    }
    
    // Supprimer un Favoris
    
    
    func deleteFavorite(item: IndexSet) {
        favoriteCryptos.remove(atOffsets: item)
    }
    
    func removeFavoriteCrypto(item: Data) {
        self.favoriteCryptos.removeAll {
            $0.id == item.id
        }
    }
    
    // Fonction si déjà en favoris supprimer sinon ajouter
    
    
    func addOrRemoveFavorite(item: Data) {
        if favoriteCryptos.contains(item) {
            removeFavoriteCrypto(item: item)
        } else {
            addFavorite(item: item)
        }
    }
    
}

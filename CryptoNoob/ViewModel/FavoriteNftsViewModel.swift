//
//  FavoriteNftsViewModel.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 10/07/2022.
//

import Foundation
import Crypto4FunKit

class FavoriteNftsViewModel: ObservableObject {
    @Published var favoriteNfts: [NFTModel]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([NFTModel].self, from: data) {
                favoriteNfts = decoded
                return
            }
        }
        // No Saved data
        favoriteNfts = []
    }

    func saveNft() {
        if let encoded = try? JSONEncoder().encode(favoriteNfts) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
    
    func addNft(nft: NFTModel) {
        favoriteNfts.append(nft)
    }
    
    func removeNft(nft: NFTModel) {
        self.favoriteNfts.removeAll {
            $0.id == nft.id
        }
    }
    
    func addOrRemoveNft(nft: NFTModel) {
        
        if favoriteNfts.contains(nft) {
            removeNft(nft: nft)
            saveNft()
        } else {
            addNft(nft: nft)
            saveNft()
        }
    }
    
    func deleteNft(nft: IndexSet) {
        favoriteNfts.remove(atOffsets: nft)
        saveNft()
    }
}

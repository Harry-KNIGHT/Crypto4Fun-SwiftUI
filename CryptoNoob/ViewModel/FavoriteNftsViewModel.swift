//
//  FavoriteNftsViewModel.swift
//  CryptoNoob
//
//  Created by Nyl Neuville on 10/07/2022.
//

import Foundation

class FavoriteNftsViewModel: ObservableObject {
    @Published var favoriteNfts = [NFTModel]()
    
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
        } else {
            addNft(nft: nft)
        }
    }
    
    func deleteNft(nft: IndexSet) {
        favoriteNfts.remove(atOffsets: nft)
    }
}

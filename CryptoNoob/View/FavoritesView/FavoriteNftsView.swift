//
//  FavoriteNftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 09/07/2022.
//

import SwiftUI

struct FavoriteNftsView: View {
    @EnvironmentObject var nftVM: FavoriteNftsViewModel
    var body: some View {
		List {
            ForEach(nftVM.favoriteNfts) { nft in
                    NftListRowCell(nft: nft)
            }
            .onDelete(perform: nftVM.deleteNft)
		}
    }
}

struct FavoriteNftsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNftsView()
            .environmentObject(FavoriteNftsViewModel())
    }
}

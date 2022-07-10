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
		if nftVM.favoriteNfts.isEmpty {
			EmptyView(text: "No favorite NFT", sfSymbol: "xmark.seal.fill")
			Spacer()
		}else {
			List {
				ForEach(nftVM.favoriteNfts) { nft in
					NftListRowCell(nft: nft)
				}
			}
		}
    }
}

struct FavoriteNftsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNftsView()
            .environmentObject(FavoriteNftsViewModel())
    }
}

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
			ScrollView{
				VStack{
					ForEach(nftVM.favoriteNfts) { nft in
						NavigationLink(destination: NftDetailView(nft: nft)) {
							NftListRowCell(nft: nft)
						}
						.padding(10)
						.background(.regularMaterial)
						.cornerRadius(10)
					}
				}
			}
			.padding(.horizontal)
		}
	}

}

struct FavoriteNftsView_Previews: PreviewProvider {
	static var previews: some View {
		FavoriteNftsView()
			.environmentObject(FavoriteNftsViewModel())
	}
}

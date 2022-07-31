//
//  SwipeFavoriteNFT.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import SwiftUI

struct SwipeFavoriteNFT: View {
	var nft: NFTModel
    var body: some View {
		SwipeItem(content: {
			NftListRowCell(nft: nft)

		}, left: {
			ZStack {
				Rectangle()
					.fill(Color.red)
				Image(systemName: "plus")
			}
		}, right: {
			Rectangle()
				.fill(Color.red)
				Image(systemName: "plus")

		}, itemHeight: 50)
    }
}

struct SwipeFavoriteNFT_Previews: PreviewProvider {
    static var previews: some View {
		 SwipeFavoriteNFT(nft: NFTModel(rank: 1, iconURL: "https://d1nht67oz99wd1.cloudfront.net/resized/BoredApeYachtClub_resized.ico", contractName: "Bored Ape Yacht Club", productPath: "bored-ape-yacht-club", baseCurrency: .eth, isSalesOnly: false, value: 165809.354511213, valueUSD: 10207307.4, platform: 0, buyers: 76, sellers: 97, owners: 0, transactions: 122, changeInValueUSD: -17.106837664027900, previousValue: 182801.49779153, previousValueUSD: 12313811.07, isSlamLandDisabled: false))
    }
}

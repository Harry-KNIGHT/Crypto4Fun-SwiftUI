//
//  AsyncIconUrlView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 07/07/2022.
//

import SwiftUI

struct AsyncIconUrlView: View {
	var nft: NFTModel
	var width: CGFloat = 100
	var height: CGFloat = 100
	@State private var isLoading = false

	var body: some View {
		AsyncImage(url: URL(string: nft.iconURL ?? "")) { image in
			image
				.resizable()
				.scaledToFit()
		}placeholder: {
			ProgressView()
		}
		.frame(width: width, height: height, alignment: .center)
	}
}

struct AsyncIconUrlView_Previews: PreviewProvider {
    static var previews: some View {
		AsyncIconUrlView(nft: NFTModel(rank: 1, iconURL: "https://d1nht67oz99wd1.cloudfront.net/resized/BoredApeYachtClub_resized.ico", contractName: "Bored Ape Yacht Club", productPath: "bored-ape-yacht-club", baseCurrency: .eth, isSalesOnly: false, value: 165809.354511213, valueUSD: 10207307.4, platform: 0, buyers: 76, sellers: 97, owners: 0, transactions: 122, changeInValueUSD: -17.106837664027900, previousValue: 182801.49779153, previousValueUSD: 12313811.07, isSlamLandDisabled: false))
    }
}

//
//  NftDetailView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 07/07/2022.
//

import SwiftUI

struct NftDetailView: View {
	var nft: NFTModel
	let gradient = LinearGradient(colors: [.green, .black], startPoint: .top, endPoint: .center)
	var body: some View {
		List {
			VStack(spacing: 35) {
				HStack {
					Spacer()
					VStack {
						AsyncIconUrlView(nft: nft)
							.clipShape(RoundedRectangle(cornerRadius: 10))


						Text(nft.contractName)
							.font(.title3.bold())
						Text(nft.baseCurrency.rawValue)
							.font(.headline)
					}
					Spacer()
				}
				NftCollectionInformationView(information: "Price", value: "$\(String(nft.valueUSD))")
			}

			NftCollectionInformationView(information: "Buyers:", value: String(nft.buyers))

			NftCollectionInformationView(information: "Sellers:", value: String(nft.sellers))

			NftCollectionInformationView(information: "Transactions:", value: String(nft.transactions))

		}.listStyle(.plain)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					Button(action: {}, label: {
						Label("Add to favorites", systemImage: "heart")
					})
				}
			}
	}
}

struct NftDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			NftDetailView(nft: NFTModel(rank: 1, iconURL: "https://d1nht67oz99wd1.cloudfront.net/resized/BoredApeYachtClub_resized.ico", contractName: "Bored Ape Yacht Club", productPath: "bored-ape-yacht-club", baseCurrency: .eth, isSalesOnly: false, value: 165809.354511213, valueUSD: 10207307.4, platform: 0, buyers: 76, sellers: 97, owners: 0, transactions: 122, changeInValueUSD: -17.106837664027900, previousValue: 182801.49779153, previousValueUSD: 12313811.07, isSlamLandDisabled: false))
		}
	}
}

struct NftCollectionInformationView: View {
	var information: String
	var value: String

	var body: some View {
		HStack {
			Text(information)
			Spacer()
			Text(value)
				.font(.headline)
		}
	}
}

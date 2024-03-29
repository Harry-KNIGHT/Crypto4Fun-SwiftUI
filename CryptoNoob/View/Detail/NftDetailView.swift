//
//  NftDetailView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 07/07/2022.
//

import SwiftUI
import Crypto4FunKit

struct NftDetailView: View {
	var nft: NFTModel
	let gradient = LinearGradient(colors: [.green, .black], startPoint: .top, endPoint: .center)
    @EnvironmentObject public var nftVM: FavoriteNftsViewModel
    
	var body: some View {
		VStack {
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
						}
						Spacer()
					}

					NftCollectionInformationView(information: "Price:", value: "$\(String(format: "%.2f", nft.valueUSD))")
				}

				HStack {
					Text("Price change:")
					Spacer()
					NftLastTimeRangePercentage(nft: nft)
				}


				NftCollectionInformationView(information: "Buyers:", value: String(nft.buyers))

				NftCollectionInformationView(information: "Sellers:", value: String(nft.sellers))

				NftCollectionInformationView(information: "Transactions:", value: String(nft.transactions))
			}


			.listStyle(.plain)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					Button(action: {
                        nftVM.addOrRemoveNft(nft: nft)
                        nftVM.saveNft()
                    }, label: {
                        Label("Add to favorites", systemImage: !nftVM.favoriteNfts.contains(nft) ? "heart" : "heart.fill")
							.font(.title3)
							.foregroundColor(.primary)

					})
				}
		}
			/*Button(action: {

			}, label: {
				Label("Voir la collection", systemImage: "network")
					.font(.headline)
					.padding(8)

			})
			.buttonBorderShape(.roundedRectangle(radius: 10))
			.buttonStyle(.bordered)

			.tint(.primary)*/
		}
	}
}

struct NftDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			NftDetailView(nft: .nftSample)
                .environmentObject(FavoriteNftsViewModel())
		}
        
	}
}

struct NftCollectionInformationView: View {
	var information: String
	var value: String

	var body: some View {
		HStack {
			Text(information)
				.foregroundColor(.primary)
			Spacer()
			Text(value)
				.font(.headline)
		}
	}
}

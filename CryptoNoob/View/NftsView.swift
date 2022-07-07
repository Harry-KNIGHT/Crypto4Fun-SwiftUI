//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
	@EnvironmentObject var apiCall: ApiCall
	var body: some View {
		if apiCall.nft.isEmpty {
			VStack {
				Spacer()
				HStack(spacing: 10) {
					ProgressView()
					Text("Fetching Data...")
						.font(.title2)
						.foregroundStyle(.secondary)
				}
				Spacer()
			}
		}
        List(apiCall.nft) { nft in
			NavigationLink(destination: NftDetailView(nft: nft)) {
				HStack {
					AsyncIconUrlView(nft: nft, width: 50, height: 50)
						.clipShape(RoundedRectangle(cornerRadius: 10))
					VStack(alignment: .leading) {
						Text(nft.contractName)
							.font(.headline)
						Text(nft.baseCurrency.rawValue)
					}

					Spacer()

					Text("\(String(format: "%.2f", nft.changeInValueUSD ?? "0"))%")
						.foregroundStyle(nft.changeInValueUSD ?? 0 >= 0 ? .green : .red)
				}
			}
		}
		.listStyle(.plain)
		.task {
			await apiCall.fetchNFT()
		}
	}
}

struct NftsView_Previews: PreviewProvider {
	static var previews: some View {
		NftsView()
			.environmentObject(ApiCall())
	}
}

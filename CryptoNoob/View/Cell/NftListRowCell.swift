//
//  NftListRowCell.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 10/07/2022.
//
import SwiftUI

import Foundation
struct NftListRowCell: View {
	var nft: NFTModel
	var body: some View {
		HStack {
			AsyncIconUrlView(nft: nft, width: 50, height: 50)
				.clipShape(RoundedRectangle(cornerRadius: 10))
			VStack(alignment: .leading) {
				Text(nft.contractName)
					.font(.headline)
				Text(nft.baseCurrency.rawValue)
			}

			Spacer()

			NftLastTimeRangePercentage(nft: nft)
		}
	}
}

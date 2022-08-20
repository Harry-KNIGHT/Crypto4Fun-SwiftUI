//
//  AsyncIconUrlView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 07/07/2022.
//

import SwiftUI
import Crypto4FunKit

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
		AsyncIconUrlView(nft: .nftSample)
    }
}

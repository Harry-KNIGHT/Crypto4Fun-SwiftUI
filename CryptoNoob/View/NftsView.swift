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
        List(apiCall.nft) { nft in
            Text(nft.contractName)
		}.task {
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

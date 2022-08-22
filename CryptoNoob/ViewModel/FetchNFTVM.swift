//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation
import Crypto4FunKit

class FetchNftViewModel: ObservableObject {
    @Published public var nfts = [NFTModel]()

	@MainActor func getNFT(_ timeRange: NftTimeRange) async throws {
		do {
			nfts = try await FetchNftApi.fetchNFT(timeRange)
		} catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}

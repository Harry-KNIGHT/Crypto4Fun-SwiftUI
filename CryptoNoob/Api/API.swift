//
//  API.swift
//  MyWallet
//
//  Created by Elliot Knight on 17/06/2022.
//

import Foundation

class ApiCall: ObservableObject {
    @Published public var nft = [NFTModel]()

	func fetchNFT(_ timeRange: NftTimeRange) async {
		let url = "https://api.cryptoslam.io/v1/collections/top-100?timeRange=\(timeRange.rawValue)"

        guard let url = URL(string: url) else {
            print("Invalid NFT url")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
				print("Bad http response")
				return
			}

            if let decodedResponse = try? JSONDecoder().decode([NFTModel].self, from: data) {
                DispatchQueue.main.async {
					print("Succes request for \(timeRange)")
                    self.nft = decodedResponse
				}
            }
        } catch let jsonError as NSError {
			print("JSON decode failed: \(jsonError.localizedDescription)")
		} catch {
			print("Error occured")
		}
    }
}

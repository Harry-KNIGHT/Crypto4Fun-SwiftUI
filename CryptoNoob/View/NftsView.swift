//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
	@EnvironmentObject var fetchNft: FetchNftApi
	@State private var timeRange = 0
	var body: some View {
		if fetchNft.nfts.isEmpty {
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
		}else {
			VStack {
				HStack {
					Spacer()
					Button(action: {
						Task {
							await fetchNft.fetchNFT(NftTimeRange.day)
						}
						timeRange = 0
					}, label: {
						Text("Day")
							.font(.headline)
							.foregroundColor(.white)
							.frame(width: 100, height: 30)
					})
					.buttonBorderShape(.roundedRectangle(radius: 10))
					.buttonStyle(.borderedProminent)
					.tint(timeRange == 0 ? .blue: .secondary)


					
					Spacer()
					
					Button(action: {
						Task {
							await fetchNft.fetchNFT(NftTimeRange.week)
						}
						timeRange = 1
					}, label: {
						Text("Week")
							.font(.headline)
							.foregroundColor(.white)
							.frame(width: 100, height: 30)
					})
					.buttonBorderShape(.roundedRectangle(radius: 10))
					.buttonStyle(.borderedProminent)
					.tint(timeRange == 1 ? .blue : .secondary)
					Spacer()
					
				}
				ScrollView(.vertical, showsIndicators: false) {
					ForEach(fetchNft.nfts) { nft in
							NavigationLink(destination: NftDetailView(nft: nft)) {
								LazyVStack(alignment: .leading) {
									NftListRowCell(nft: nft)
								}
								.padding(10)
								.background(.regularMaterial)
								.cornerRadius(10)
								.shadow(color: .secondary, radius: 1.5)

							}
						}
						.padding(.horizontal)
					}
				
				.onChange(of: timeRange, perform: { _ in
					switch timeRange {
					case 0:
						Task {
							await fetchNft.fetchNFT(NftTimeRange.day)
						}
					case 1:
						Task {
							await fetchNft.fetchNFT(NftTimeRange.week)
						}
					case 2:
						Task {
							await fetchNft.fetchNFT(NftTimeRange.month)
						}
					default:
						Task {
							await fetchNft.fetchNFT(NftTimeRange.all)
						}
					}
				})
			}
		}
	}
}

struct NftsView_Previews: PreviewProvider {
	static var previews: some View {
		NftsView()
			.environmentObject(FetchNftApi())
	}
}

struct NftLastTimeRangePercentage: View {
	var nft: NFTModel
	var body: some View {
		Text("\(String(format: "%.2f", nft.changeInValueUSD ?? "0"))%")
			.foregroundStyle(nft.changeInValueUSD ?? 0 >= 0 ? .green : .red)
	}
}

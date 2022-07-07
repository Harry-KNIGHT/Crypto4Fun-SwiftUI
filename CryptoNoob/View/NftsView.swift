//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
	@EnvironmentObject var apiCall: ApiCall
	@State private var timeRange = 0
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
		VStack {
			HStack {
				Spacer()
				Picker("Select time range", selection: $timeRange) {
					Text("Day").tag(0)
					Text("Week").tag(1)
					Text("Mont").tag(2)
					Text("All").tag(3)
				}.pickerStyle(.segmented)
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
				await apiCall.fetchNFT(NftTimeRange.day)
			}
			.onChange(of: timeRange, perform: { _ in
				switch timeRange {
				case 0:
					Task {
						await apiCall.fetchNFT(NftTimeRange.day)
					}
				case 1:
					Task {
						await apiCall.fetchNFT(NftTimeRange.week)
					}
				case 2:
					Task {
						await apiCall.fetchNFT(NftTimeRange.month)
					}
				default:
					Task {
						await apiCall.fetchNFT(NftTimeRange.all)
					}
				}
			})
		}
	}
}

struct NftsView_Previews: PreviewProvider {
	static var previews: some View {
		NftsView()
			.environmentObject(ApiCall())
	}
}

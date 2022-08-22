//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts
import Crypto4FunKit

struct CurrencyChartView: View {
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@EnvironmentObject var fetchChart: FetchChartViewModel
	@State private var showAveragePrice: Bool = false
	@Environment(\.colorScheme) private var colorScheme
	var cryptoCurrency: CryptoCurrencyModel
	@State private var tagSelected = 2
	@State private var timeRemaining: Double = 1.3
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@State private var canClick: Bool = true

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading) {
				Group {
					CurrencyPriceView(cryptoCurrency: cryptoCurrency)
					NegativeOrPositiveTimeView(cryptoCurrency: cryptoCurrency)
				}.padding(.horizontal)
				Chart {
					ForEach(fetchChart.prices, id: \.self) {
						LineMark(
							x: .value("Date", Date(miliseconds: Int64($0[0]))),
							y: .value("Price", $0[1])
						)
						.foregroundStyle(fetchChart.pricePercentageValue < 0 ? .red : .green)
					}
					if showAveragePrice {
						RuleMark(
							y: .value("Average price", fetchChart.averagePrice)
						)
						.foregroundStyle(colorScheme == .dark ? .white : .black)
					}
				}
				.chartYScale(domain: .automatic(includesZero: false))
				.frame(maxWidth: .infinity, minHeight: 500, maxHeight: 700)
				.padding(.trailing, 5)
				.task {
					if canClick {
						do {
							try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.month.rawValue) ?? 0))
							timeRemaining += 0
						} catch {
							print("Error \(error.localizedDescription)")

						}
					}
				}
				.task {
					do {
						try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.week.rawValue) ?? 0))
					} catch {
						print("Error \(error.localizedDescription)")
					}
				}
				.onReceive(timer, perform: { _ in
					if timeRemaining < 0{
						canClick = true
					} else {
						canClick = false
						timeRemaining -= 1
					}
				})
				.onChange(of: tagSelected, perform: { _ in
					switch tagSelected {
					case 0:
						Task {
							if canClick {
								do {
									try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.day.rawValue) ?? 0))
									timeRemaining = 1.3
								}catch {
									print("Error \(error.localizedDescription)")
								}
							}
						}
					case 1:
						Task {
							if canClick {
								do {
									try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.week.rawValue) ?? 0))
									timeRemaining = 1.3
								} catch {
									print("Error \(error.localizedDescription)")
								}
							}
						}
					case 2:
						Task {
							if canClick {
								do {
									try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.month.rawValue) ?? 0))
									timeRemaining = 1.3
								} catch {
									print("Error \(error.localizedDescription)")
								}
							}
						}
					case 3:
						Task {
							if canClick {
								do {
									try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.year.rawValue) ?? 0))
									timeRemaining = 1.3
								} catch {
									print("Error \(error.localizedDescription)")
								}
							}
						}
					default:
						Task {
							if canClick {
								do {
									try await fetchChart.getChart(cryptoCurrency.id, from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.max.rawValue) ?? 0))
									timeRemaining = 1.3
								} catch {
									print("Error \(error.localizedDescription)")
								}
							}
						}
					}
				})
				Group {
					Picker("Select time value", selection: $tagSelected) {
						Text("Day").tag(0)
						Text("Week").tag(1)
						Text("Month").tag(2)
						Text("Year").tag(3)
						Text("Max").tag(4)
					}
					.disabled(canClick == false)
					.pickerStyle(.segmented)
					.padding(.vertical)

					Divider()
						.padding(.horizontal,40)
					ToggleAveragePriceView(showAveragePrice: $showAveragePrice)
				}
				.padding(.horizontal)
			}

		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(cryptoCurrency.name)
		.navigationBarItems(trailing: FavoriteDetailButtonView(cryptoCurrency: cryptoCurrency))
	}
}

struct CurrencyChartView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			CurrencyChartView(cryptoCurrency: .cryptoSample)
				.environmentObject(FavoriteViewModel())
				.environmentObject(FetchChartViewModel())
		}
	}
}

struct ToggleAveragePriceView: View {
	@Binding var showAveragePrice: Bool
	var body: some View {
		Toggle("Average", isOn: $showAveragePrice)
			.tint(.primary)
			.padding(.top)
	}
}

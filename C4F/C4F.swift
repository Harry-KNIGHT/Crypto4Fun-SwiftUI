//
//  C4F.swift
//  C4F
//
//  Created by Elliot Knight on 06/12/2022.
//

import WidgetKit
import SwiftUI
import Crypto4FunKit

struct Provider: TimelineProvider {

	func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), crypto: [.cryptoSample, .cryptoSample])
	}

	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(date: Date(), crypto: [.cryptoSample, .cryptoSample])
		completion(entry)
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		Task {
			do {
				let cryptos = try await CryptoApi.fetchCryptoCurrency(6)
				let entry = SimpleEntry(date: Date(), crypto: cryptos)

				let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15)))
				completion(timeline)
			} catch {

			}
		}


	}
}

struct SimpleEntry: TimelineEntry {
	let date: Date
	let crypto: [CryptoCurrencyModel]
}

struct C4FEntryView : View {
	var entry: Provider.Entry
	@Environment(\.widgetFamily) var widgetFamilies
	var body: some View {
		switch widgetFamilies {
		case .systemSmall:
			SmallWidgetView(entry: entry)
		case .systemMedium:
			MediumWidgetView(entry: entry)

		default:

			LargeWidgetView(entry: entry)
		}
	}
}

struct C4F: Widget {
	let kind: String = "C4F"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			C4FEntryView(entry: entry)
		}
		.configurationDisplayName("My Widget")
		.description("This is an example widget.")
	}
}

struct C4F_Previews: PreviewProvider {
	static var previews: some View {
		C4FEntryView(entry: SimpleEntry(date: Date(), crypto: [.cryptoSample, .cryptoSample]))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}


// MARK: Different sizes of widget views.

struct SmallWidgetView: View {
	var entry: Provider.Entry?

	var body: some View {
		if let crypto = entry?.crypto[0] {
			VStack(alignment: .leading, spacing: 15) {
				HStack(alignment: .center) {
					NetworkImage(url: URL(string: crypto.image))
					Spacer()
					Text("\(crypto.priceChangePercentage24h > 0 ? "+" : "")\(String(format: "%.2f", crypto.priceChangePercentage24h))%")
						.font(.callout)
						.foregroundColor(
							crypto.priceChangePercentage24h == 0 ? .white : crypto.priceChangePercentage24h > 0 ? .green : .red
						)
				}

				Text(crypto.name)

				Text("$\(String(format: "%.2f", crypto.currentPrice))")
					.font(.title2)
			}
			.padding()
		}
	}
}

struct MediumWidgetView: View {
	var entry: Provider.Entry
	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Spacer()
			ForEach(entry.crypto[0...1], id: \.id) { crypto in
				WigetCryptoListView(crypto: crypto)
				if crypto == entry.crypto[0] {
					Divider()
				}
			}
			Spacer()
		}
		.padding()
	}
}

struct LargeWidgetView: View {
	var entry: Provider.Entry

	var body: some View {
		VStack(alignment: .leading) {
			Spacer()
			ForEach(entry.crypto, id: \.id) { crypto in
				WigetCryptoListView(crypto: crypto)
				if crypto != (entry.crypto.last) {
					Divider()
				}
			}
			Spacer()
		}
		.padding()
	}
}


struct WigetCryptoListView: View {
	let crypto: CryptoCurrencyModel
	var body: some View {
		HStack {
			NetworkImage(url: URL(string: crypto.image))
			Text(crypto.name)
				.fontDesign(.monospaced)
				.fontWeight(.medium)
				.font(.callout)

			Spacer()
			VStack(alignment: .trailing) {
				Text("$\(String(format: "%.2f", crypto.currentPrice))")
					.font(.callout)

				Text("\(crypto.priceChangePercentage24h > 0 ? "+" : "")\(String(format: "%.2f", crypto.priceChangePercentage24h))%")
					.font(.caption)
					.foregroundColor(
						crypto.priceChangePercentage24h == 0 ? .white : crypto.priceChangePercentage24h > 0 ? .green : .red
					)
			}
		}
	}
}
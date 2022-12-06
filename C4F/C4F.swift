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
				let cryptos = try await CryptoApi.fetchCryptoCurrency(3)
				let entry = SimpleEntry(date: Date(), crypto: cryptos)

				let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15 * 60)))
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

    var body: some View {
		ForEach(entry.crypto, id: \.id) { crypto in
			Text(crypto.name)
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

//
//  NewsView.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import SwiftUI

struct NewsView: View {
	@EnvironmentObject public var news: FetchNewsApi
	@State private var showNewsSheet: Bool = false
    var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				LazyVStack {
					ForEach(news.latestNews, id: \.self) { new in
						NavigationLink(destination: WebView(url: URL(string: new.url) ?? URL(string: "http://google.com")!)) {
							LazyVStack(alignment: .leading) {
							Text(new.title.trimmingCharacters(in: .whitespacesAndNewlines))
								.foregroundColor(.primary)
								.font(.title3.bold())
								Text("Website: \(new.url)")
									.font(.body)
									.foregroundColor(.secondary)
						}
						.padding()
						.background(.regularMaterial)
						.cornerRadius(10)
						.multilineTextAlignment(.leading)
					}
					}
				}
				.shadow(color: .secondary, radius: 1.5)
				.padding(.horizontal)
				.padding(.top)
			}.task {
				do {
					try await news.fetchNews()
				} catch {
					print("Someting wrong happend, \(error.localizedDescription)")
				}
		}
		}
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
			.environmentObject(FetchNewsApi())
    }
}

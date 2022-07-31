//
//  NewsView.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import SwiftUI

struct NewsView: View {
	@EnvironmentObject public var news: FetchNewsApi
    var body: some View {
		ScrollView {
			LazyVStack(alignment: .center) {
				ForEach(news.latestNews, id: \.self) { new in
					LazyVStack() {
						Text(new.title.trimmingCharacters(in: .whitespacesAndNewlines))
							.foregroundColor(.primary)
							.font(.headline)
							.multilineTextAlignment(.center)

						Button(action: {}, label: {
							Label("Read article", systemImage: "newspaper")
								.font(.headline)
						})
						.buttonStyle(.bordered)
						.tint(.blue)

					}
					.padding()
					.background(.regularMaterial)
					.cornerRadius(10)
				}
			}
			.shadow(color: .secondary, radius: 1.5)
			.padding(.horizontal)
		}.task {
			do {
				try await news.fetchNews()
			} catch {
				print("Someting wrong happend, \(error.localizedDescription)")
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

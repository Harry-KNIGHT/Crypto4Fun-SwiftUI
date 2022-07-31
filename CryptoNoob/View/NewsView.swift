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
		VStack {
			List {
				ForEach(news.latestNews, id: \.self) { new in
					Text(new.title)
						.foregroundColor(.primary)
						.font(.headline)
					Text(new.url)
						.foregroundColor(.secondary)
				}

			}
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

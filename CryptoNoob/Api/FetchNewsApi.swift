//
//  FetchNewsApi.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import Foundation

class FetchNewsApi: ObservableObject {
	@Published public var latestNews = [NewsResponseElement]()

	func fetchNews() async throws {
		let url = "https://cryptocurrency-news-tracker.herokuapp.com/news"

		guard let url = URL(string: url) else {
			throw ApiError.urlNotFound
		}

		do {
			let (data, response) = try await URLSession.shared.data(from: url)

			guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
				throw ApiError.outOufBound
			}

			if let decodedResponse = try? JSONDecoder().decode([NewsResponseElement].self, from: data) {
				DispatchQueue.main.async {
					self.latestNews = decodedResponse

				}
			}
		} catch {
			print("Error while fetching news data: \(error.localizedDescription)")
		}
	}
}


enum ApiError: Error {
	case urlNotFound, outOufBound
}

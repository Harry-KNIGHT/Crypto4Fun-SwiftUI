//
//  FetchNewsApi.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import Foundation
import Crypto4FunKit

class FetchNewsViewModel: ObservableObject {
	@Published public var latestNews = [NewsModel]()

	@MainActor func getNews() async throws {
		do {
			latestNews = try await NewsApi.fetchNews()
		} catch {
			print("Error \(error.localizedDescription)")
		}
	}
}

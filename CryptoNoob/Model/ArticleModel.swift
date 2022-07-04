//
//  ArticleModel.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 04/07/2022.
//

import Foundation

// MARK: - ArticleResponse
struct ArticleResponse: Codable {
	let status: String
	let totalResults: Int
	let articles: [ArticleModel]
}

// MARK: - Article
struct ArticleModel: Identifiable, Codable, Hashable {
	var id = UUID()
	// let source: Source?
	let author: String?
	let title, articleDescription: String
	let url: String
	let urlToImage: String?
	let publishedAt: Date
	let content: String

	enum CodingKeys: String, CodingKey {
		// case source,
		case author, title
		case articleDescription = "description"
		case url, urlToImage, publishedAt, content
	}
}
/*
// MARK: - Source
struct Source: Codable, Hashable {
	let id: String?
	let name: String
}
*/

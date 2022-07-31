//
//  NewsModel.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 31/07/2022.
//

import Foundation

struct NewsResponseElement: Hashable, Codable {
	let title: String
	let url: String
	let source: Source
}

enum Source: String, Codable {
	case cryptonewsCOM = "cryptonews.com"
	case cryptonewsNet = "cryptonews.net"
}

typealias NewsResponse = [NewsResponseElement]

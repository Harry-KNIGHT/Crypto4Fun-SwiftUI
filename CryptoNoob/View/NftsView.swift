//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
	@EnvironmentObject var apiCall: ApiCall
	var body: some View {
		List(apiCall.articles) { article in
			Text(article.author ?? "")
		}.task {
			await apiCall.fetchArticle()
		}
	}
}

struct NftsView_Previews: PreviewProvider {
	static var previews: some View {
		NftsView()
			.environmentObject(ApiCall())
	}
}

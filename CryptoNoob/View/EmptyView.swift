//
//  EmptyView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 18/06/2022.
//

import SwiftUI

struct EmptyView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
	var text: String
	var sfSymbol: String
    var body: some View {
        VStack(spacing: 10) {
                Image(systemName: sfSymbol)
                Text(text)
        }
		.multilineTextAlignment(.center)
		.font(.largeTitle.bold())
        .foregroundColor(.secondary)
        .padding()
    }
}


//
//  EmptyView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 18/06/2022.
//

import SwiftUI

struct EmptyView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    var body: some View {
        VStack(spacing: 10) {
            if favoriteVM.favoriteCryptos.isEmpty {
                Image(systemName: "xmark.seal.fill")
                Text("Aucun favoris")
            }
        }
        .font(.system(size: 50))
        .foregroundColor(.secondary)
        .padding()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
            .environmentObject(FavoriteViewModel())
    }
}

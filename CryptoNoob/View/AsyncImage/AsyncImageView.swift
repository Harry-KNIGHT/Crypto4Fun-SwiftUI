//
//  AsyncImageView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI
import Crypto4FunKit

struct AsyncImageView: View {
    let cryptoCurrency: CryptoCurrencyModel
    var width: CGFloat = 150
    var height: CGFloat = 150
    @State private var isLoading = false

    var body: some View {
        AsyncImage(url: URL(string: cryptoCurrency.image)) { image in
            image
                .resizable()
                .scaledToFit()
        }placeholder: {
				ProgressView()
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
		AsyncImageView(cryptoCurrency: .cryptoSample)
    }
}

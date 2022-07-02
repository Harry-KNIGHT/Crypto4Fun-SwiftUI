//
//  AsyncImageView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct AsyncImageView: View {
    let data: Data
    var width: CGFloat = 150
    var height: CGFloat = 150
    @State private var isLoading = false

    var body: some View {
        AsyncImage(url: URL(string: data.image)) { image in
            image
                .resizable()
                .scaledToFit()
        }placeholder: {
            ZStack {

                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 10)
                    .frame(width: width, height: height)

                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.orange, lineWidth: 7)
                    .frame(width: width, height: height)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .onAppear {
                        self.isLoading = true
                    }
            }
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -0.26766))
    }
}

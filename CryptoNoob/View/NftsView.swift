//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
    var ntfs = ["Bored APE", "Oul ou", "HIHI", "Didier la Banque Postale", "Fédérico"]
    var body: some View {
        ScrollView {
            ForEach(ntfs, id: \.self) { nft in
                VStack {
                    HStack {
                        Text(nft)
                        Spacer()
                    }
                }
            }
        }.padding()
    }
}

struct NftsView_Previews: PreviewProvider {
    static var previews: some View {
        NftsView()
    }
}

//
//  NftsView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct NftsView: View {
    var ntfs = ["Bored APE", "Oul ou", "HIHI"]
    var body: some View {
        ForEach(ntfs, id: \.self) { nft in
            VStack {
                Text(nft)
            }
        }
    }
}

struct NftsView_Previews: PreviewProvider {
    static var previews: some View {
        NftsView()
    }
}

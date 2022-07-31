//
//  SelectViewPickerView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 09/07/2022.
//

import SwiftUI

struct SelectViewPickerView: View {
	var info: String
	@Binding var selection: Int
	var body: some View {
		Picker(info, selection: $selection) {
			Text("Cryptos").tag(0)
			Text("NFT").tag(1)
			Text("News").tag(2)
		}
		.pickerStyle(.segmented)
		.padding(.horizontal)
	}
}

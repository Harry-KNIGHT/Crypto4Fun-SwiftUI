//
//  MainView.swift
//  MyWallet
//
//  Created by Elliot Knight on 12/06/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var apiCall: ApiCall
    @State private var isOn: Bool = false
    @State private var selection = 0

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select", selection: $selection) {
                    Text("Cryptos").tag(0)
                    Text("NTF").tag(1)
                }
                .pickerStyle(.segmented)
                    .padding(.horizontal)
                if selection == 0 {
                    CryptoCurrencyListView()
                } else {
					NftsView()
                }
            }
            .navigationBarItems(trailing: FavoriteButtonSheetView(isOn: $isOn))
            .navigationTitle("Crypto4Fun")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(ApiCall())
    }
}

struct FavoriteButtonSheetView: View {
    @Binding var isOn: Bool
    var body: some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            Label("Like button", systemImage: "heart.fill")
                .font(.title3)
                .foregroundColor(.primary)
        }).sheet(isPresented: $isOn) {
            FavoriteListView()
        }
    }
}

struct ListRowCellView: View {
	var cryptoCurrency: CryptoCurrencyModel
    var body: some View {
        HStack {
            AsyncImageView(cryptoCurrency: cryptoCurrency, width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(cryptoCurrency.name)
                    .font(.headline)
                Text("$" + String(cryptoCurrency.currentPrice.formatted()))
                    .font(.body)
            }
            Spacer()
			HStack(spacing: 5) {
				Image(systemName: cryptoCurrency.priceChangePercentage24h < 0 ? "chevron.down" : "chevron.up")
				Text("\(String(format: "%.2f", cryptoCurrency.priceChangePercentage24h))% ")
			}
			.foregroundColor(cryptoCurrency.priceChangePercentage24h < 0 ? .red : .green)
			.font(.body)
        }
    }
}

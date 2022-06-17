//
//  MainView.swift
//  MyWallet
//
//  Created by Elliot Knight on 12/06/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var apiCall: ApiCall

    var body: some View {
        NavigationView {
            List(apiCall.datas, id: \.id) { item in
                NavigationLink(destination: DetailView(data: item)) {
                HStack {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    }placeholder: {
                        Color.secondary
                    }
                    .frame(width: 40, height: 40)
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(String(item.currentPrice))
                    }
                }
                }
            }
            .navigationTitle("My Crypto")
            .task {
                await apiCall.fetchData()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

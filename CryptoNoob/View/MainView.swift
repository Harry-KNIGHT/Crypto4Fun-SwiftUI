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
                        AsyncImageView(data: item, width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            HStack(spacing: 1) {
                                Text("$")
                                    .bold()
                                Text(String(item.currentPrice.formatted()))
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Crypto")
            .task {
                await apiCall.fetchData()
                
            }
        }
        .refreshable {
            await apiCall.fetchData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ApiCall())
    }
}

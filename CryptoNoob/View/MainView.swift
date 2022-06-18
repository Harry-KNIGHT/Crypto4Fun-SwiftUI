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
    var body: some View {
        NavigationView {
            List(apiCall.datas, id: \.id) { item in
                NavigationLink(destination: DetailView(data: item)) {
                    HStack {
                        AsyncImageView(data: item, width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            HStack(alignment: .center, spacing: 1) {
                                Text("$")
                                    .bold()
                                Text(String(item.currentPrice.formatted()))
                                Spacer()

                            }
                        }
                        Text("\(String(format: "%.2f", item.priceChangePercentage24h))% ")
                            .foregroundColor(item.priceChangePercentage24h < 0 ? Color.red : Color.green)
                    }
                }
            }
            .navigationBarTitle("Crypto Noob", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isOn.toggle()
                
            }, label: {
                           Label("Like button", systemImage: "heart")
            }).sheet(isPresented: $isOn) {
                FavoriteListView()
            })
                
            
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
            .preferredColorScheme(.dark)
            .environmentObject(ApiCall())
    }
}

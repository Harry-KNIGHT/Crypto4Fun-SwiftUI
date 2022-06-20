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
        NavigationStack {
            List(apiCall.datas, id: \.id) { item in
                 NavigationLink(destination: CurrencyChartView(data: item)) {
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
                        NegativeOrPositiveLast24hView(data: item, font: .body)
                    }

                }
                 .navigationBarTitle("Crypto4Fun", displayMode: .inline)
            }

            .navigationBarTitle("Crypto Noob", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isOn.toggle()
                
            }, label: {
                           Label("Like button", systemImage: "heart.fill")
                    .font(.title3)
                .foregroundColor(.primary)
            }).sheet(isPresented: $isOn) {
                FavoriteListView()
            })   


            .task {
                await apiCall.fetchData()

            }
            .onReceive(apiCall.timer) { time in
              apiCall.fetchDataTimer()
            }
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

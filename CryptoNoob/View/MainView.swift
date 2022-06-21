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
            List(apiCall.datas, id: \.id) { data in
                NavigationLink(destination: CurrencyChartView(data: data)) {
                    ListRowCellView(data: data)
                }

            }
            .navigationBarItems(trailing: FavoriteButtonSheetView(isOn: $isOn))
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
    var data: Data
    var body: some View {
        HStack {
            AsyncImageView(data: data, width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.headline)
                Text("$" + String(data.currentPrice.formatted()))
                    .font(.body)
            }
            Spacer()
            NegativeOrPositiveLast24hView(data: data, font: .body)
        }
    }
}

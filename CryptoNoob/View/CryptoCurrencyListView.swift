//
//  CryptoCurrencyListView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 23/06/2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
    @EnvironmentObject var apiCall: ApiCall

    var body: some View {
        List(apiCall.datas, id: \.id) { data in
            NavigationLink(destination: CurrencyChartView(data: data)) {
                ListRowCellView(data: data)
            }
        }.task {
            await apiCall.fetchData()
        }
        .onReceive(apiCall.timer) { time in
            apiCall.fetchDataTimer()
        }
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView()
            .environmentObject(ApiCall())
    }
}

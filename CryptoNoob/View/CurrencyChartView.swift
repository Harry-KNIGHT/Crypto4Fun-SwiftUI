//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts

struct CurrencyChartView: View {
    @EnvironmentObject var chartApiResponse: ApiCall
    @State private var showAveragePrice: Bool = true
    @State private var timeToShow = "D"
    var timesToShow = ["M", "D", "Y"]
    var body: some View {
        VStack {

            Chart {
                ForEach(chartApiResponse.prices, id: \.self) {
                    LineMark(x: .value("Date", Date(miliseconds: Int64($0[0]))),
                             y: .value("Price", $0[1])
                    ).foregroundStyle(.purple)
                }

                if showAveragePrice {
                    RuleMark(
                        y: .value("Threshold", chartApiResponse.averagePrice)
                    ).foregroundStyle(.orange)
                }
            }
            .task {
                await chartApiResponse.fetchChart()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bitcoin")
            VStack(spacing: 10) {
                Toggle("Average price", isOn: $showAveragePrice)
                Picker("Chose time", selection: $timeToShow) {
                    ForEach(timesToShow, id: \.self) {
                        Text($0)
                    }

                }.pickerStyle(.segmented)
            }.padding()
        }.padding(.vertical)
    }
}

struct CurrencyChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyChartView()
            .environmentObject(ApiCall())
    }
}

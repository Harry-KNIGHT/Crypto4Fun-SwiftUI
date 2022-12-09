//
//  ChartView.swift
//  Crypto4Fun
//
//  Created by Elliot Knight on 09/12/2022.
//

import SwiftUI
import Charts

struct ChartView: View {
	@EnvironmentObject var chartVM: FetchChartViewModel
	@Binding var showAveragePrice: Bool
	@Environment(\.colorScheme) var colorScheme
	var minHeight: CGFloat = 500
	var maxHeight: CGFloat = 700
    var body: some View {
		Chart {
			ForEach(chartVM.prices, id: \.self) {
				LineMark(
					x: .value("Date", Date(miliseconds: Int64($0[0]))),
					y: .value("Price", $0[1])
				)
				.foregroundStyle(chartVM.pricePercentageValue < 0 ? .red : .green)
			}
			if showAveragePrice {
				RuleMark(
					y: .value("Average price", chartVM.averagePrice)
				)
				.foregroundStyle(colorScheme == .dark ? .white : .black)
			}
		}
		.chartYScale(domain: .automatic(includesZero: false))
		.frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
		.padding(.trailing, 5)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
		ChartView(showAveragePrice: .constant(false))
			.environmentObject(FetchChartViewModel())
    }
}

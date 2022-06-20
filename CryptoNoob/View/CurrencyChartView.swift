//
//  CurrencyChartView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 19/06/2022.
//

import SwiftUI
import Charts

struct CurrencyChartView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    @EnvironmentObject var chartApiResponse: ApiCall
    @State private var showAveragePrice: Bool = false
    @State var range: (Date, Date)? = nil

    var data: Data

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("$" + String(data.currentPrice))
                    .foregroundColor(.primary)
                    .font(.largeTitle.bold())
                NegativeOrPositiveLast24hView(data: data, font: .body)

            }                    .padding(.horizontal)


            Chart {
                ForEach(chartApiResponse.prices, id: \.self) {
                    LineMark(x: .value("Date", Date(miliseconds: Int64($0[0]))),
                             y: .value("Price", $0[1])
                    )

                    .foregroundStyle(data.priceChangePercentage24h < 0 ? .red : .green)

                }

                if showAveragePrice {
                    RuleMark(
                        y: .value("Threshold", chartApiResponse.averagePrice)
                    ).foregroundStyle(.primary)
                }
            }.chartOverlay { proxy in
                GeometryReader { g in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(DragGesture()
                            .onChanged { value in
                                // Find the x coordinates in the chart's plot area.
                                let startX = value.startLocation.x - g[proxy.plotAreaFrame].origin.x
                                let currentX = value.location.x - g[proxy.plotAreaFrame].origin.x
                                // Find the date values at the x coordinates.
                                if let startDate: Date = proxy.value(atX: startX),
                                   let currentDate: Date = proxy.value(atX: currentX) {
                                    range = (startDate, currentDate)
                                }
                            }
                            .onEnded { _ in range = nil } // Clear state on gesture end
                        )
                }
            }
            .task {
                await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.monthly)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(data.name)
            .navigationBarItems(trailing: Button(action: {
                favoriteVM.addOrRemoveFavorite(item: data)
            }, label: {
                Label("Favorite", systemImage: favoriteVM.favoriteCryptos.contains(data) ? "heart.fill" : "heart")
                    .foregroundColor(.primary)
                    .font(.title3)
            }) )
            Toggle("Moyenne", isOn: $showAveragePrice)
                .tint(.primary)
                .padding(.horizontal)
                .padding(.top)
            Divider()
                .padding(.horizontal, 50)
            HStack {
                /*
                 Button(action: {
                 Task {
                 await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.max)
                 }
                 }, label: {
                 Text("Day")
                 })
                 .modifier(ButtonTimeSelected())
                 */


                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.monthly)
                    }
                }, label: {
                    Text("MONTH")
                })
                .modifier(ButtonTimeSelected())

                Spacer()

                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.yearly)
                    }
                }, label: {
                    Text("YEAR")
                })
                .modifier(ButtonTimeSelected())

                Spacer()

                Button(action: {
                    Task {
                        await chartApiResponse.fetchChart(data.id, timeChartShow: ApiCall.TimeToShow.max)
                    }
                }, label: {
                    Text("MAX")
                })
                .modifier(ButtonTimeSelected())


            }.padding()

        }
    }

}



struct CurrencyChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyChartView(data: Data(id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FavoriteViewModel())
            .environmentObject(ApiCall())
    }
}

struct ButtonTimeSelected: ViewModifier {
    func body(content: Content) -> some View {
        content

            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.primary)


    }
}

//
//  GameView.swift
//  Crypto4Fun
//
//  Created by Nyl Neuville on 31/07/2022.
//

import SwiftUI
import Charts

struct GameView: View {
    @EnvironmentObject var fetchChart: FetchChartApi
    var cryptoCurrency: CryptoCurrencyModel
    private func circleStyle(_color: Color, _typeOrder: String) -> some View {
        ZStack {
            Circle().stroke(lineWidth: 4)
                .background {
                Circle().opacity(0.4)
            }
            .foregroundColor(_color)
            Text(_typeOrder)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
        }
    }
    private func templateTakePosition(_color: Color, _degree: Angle = Angle(degrees: 0.0)) -> some View {
        HStack {
            
            shortIsPressed ? Spacer() : nil
            
                GameBetCustomShape()
                    .foregroundColor(_color).opacity(0.44)
                    .frame(maxWidth: UIScreen.main.bounds.size.width / 1.2 , maxHeight: .infinity)
                        .rotationEffect(_degree)
                        .background {
                            BlurView(style: .systemUltraThinMaterialLight).ignoresSafeArea()
                                .opacity(0.80)
                                .mask {
                                GameBetCustomShape()
                                    .rotationEffect(_degree)
                            }
                        }
                        .overlay {
                            GameBetCustomShape().stroke(lineWidth: 5)
                                .foregroundColor(_color)
                                .rotationEffect(_degree)
                        }
                        
            
            longIsPressed ? Spacer() : nil
        }.ignoresSafeArea()
    }
    //MARK: Variable for the ZOOM effect
    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 0
    
    @State private var longIsPressed = false
    @State private var shortIsPressed = false
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            VStack {
                //MARK: Background with Chart
                ZStack {
                    Image("GameTemplate").ignoresSafeArea()
                    Chart {
                        ForEach(fetchChart.prices, id: \.self) {
                            LineMark(
                                x: .value("Date", Date(miliseconds: Int64($0[0]))),
                                y: .value("Price", $0[1])
                            
                            
                            )
                            .foregroundStyle(fetchChart.pricePercentageValue < 0 ? .red : .green)
                            
                            
                        }
                    }
                        .chartYScale(domain: .automatic(includesZero: false))
                        .frame(width: 350, height: 300)
                        .offset(y: -80)
                        .task {

                                await fetchChart.fetchChart("bitcoin", from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.month.rawValue) ?? 0))

                        }
                        
                }
                .scaleEffect(1 + currentScale)
                .gesture(
                MagnificationGesture()
                    .onChanged { newScale in
                        currentScale = newScale - 1
                    }
                    .onEnded { scale in
                        withAnimation(.spring()) {
                            currentScale = 0
                        }
                    }
                )
                Spacer()
                
                HStack {
                    circleStyle(_color: .cyan, _typeOrder: "LONG")
                        .onTapGesture {
                            longIsPressed.toggle()
                            shortIsPressed = false
                        }
                    Spacer()
                    circleStyle(_color: .purple, _typeOrder: "SHORT")
                        .onTapGesture {
                            shortIsPressed.toggle()
                            longIsPressed = false
                        }
                }.padding(.horizontal, 35 )
            }
            
            //MARK: VIEW IF LONG BUTTON IS PRESSED
            if longIsPressed {
                
                    templateTakePosition(_color: .cyan)
                
            }
            if shortIsPressed {
                templateTakePosition(_color: .purple, _degree: Angle(degrees: 180))
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameView(cryptoCurrency: CryptoCurrencyModel(
                id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FetchChartApi())
        }
    }
}

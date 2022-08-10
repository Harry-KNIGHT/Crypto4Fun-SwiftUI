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
    @EnvironmentObject var crypto: CryptoApiCall
    var cryptoCurrency: CryptoCurrencyModel
    @State private var selectedCrypto = "bitcoin"
    
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
        
        .frame(width: 100, height: 100)
        .padding()
        //MARK: Condition if it's height device it's 667 
        .offset(y: UIScreen.main.bounds.height == 667.00 ? (-UIScreen.main.bounds.height / 6) : (-UIScreen.main.bounds.height / 15))
    }
    
    //MARK: 3 Variables for the timer
    @State var countDownTimer = 10 // 5minutes
    @State var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //MARK: View to take a position
    @State private var pricePosition: Double = 0.0
    @State private var endPricePosition: Double = 0.0
    @State private var idPosition = ""
    var cryptoName = [""]
    
    private func templateTakePosition(_color: Color, _degree: Angle = Angle(degrees: 0.0)) -> some View {
        
        ZStack() {
            
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
            
            
            //MARK: View above the template (long/short position view)
            VStack() {
                
                Spacer()
                Spacer()
                if countDownTimer == 0 {
                    Text("tu es rentré à \(pricePosition) \n le prix actuel est \(endPricePosition)")
                        .foregroundColor(.white)
                }
                Text("\(UIScreen.main.bounds.height)")
                Text("price position \(pricePosition)").foregroundColor(.white)
                Text("end price position \(endPricePosition)").foregroundColor(.white)
                Text("\(countDownTimer)")
                HStack() {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        idPosition = "long"
                        Task {
                             await crypto.fetchCryptoCurrency()
                        }
                        print(crypto.cryptoCurrencies[0].currentPrice)
//                        pricePosition = cryptoCurrency.currentPrice
                        pricePosition = crypto.cryptoCurrencies[0].currentPrice
                        print(pricePosition)
                         countDownTimer = 10
                        endPricePosition = 0.0
                         timerRunning = true
                        
                    }, label: {
                        Text("Valider")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background {
                                RoundedRectangle(cornerRadius: 20 )
                                    .stroke(lineWidth: 3)
                                    
                            }
                            .foregroundColor(.white)
                    })
                    .onReceive(timer) { _ in
                        if countDownTimer > 0 && timerRunning {
                            countDownTimer -= 1
                        } else {
                            timerRunning = false
                            
                            if countDownTimer == 0 && endPricePosition == 0.0 {
//                                endPricePosition = cryptoCurrency.currentPrice
                                Task {
                                    await crypto.fetchCryptoCurrency()
                                    endPricePosition = crypto.cryptoCurrencies[0].currentPrice
                                    print(endPricePosition)
                                }
                                
                                
                            }
//                            countDownTimer = 10
                            
                        }
                    }
                    
                Spacer()
                Spacer()
                    
                }
                Spacer()
            }
        }
    }
        
    //MARK: Variable for the ZOOM effect
    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 0
    
    @State private var longIsPressed = false
    @State private var shortIsPressed = false
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                VStack {
                    //MARK: Background with Chart
                    ZStack {
                        Image("GameTemplate").edgesIgnoringSafeArea(.bottom)
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
                            
                            .chartYAxis {
                              AxisMarks(values: .automatic) { value in
                                AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                                  .foregroundStyle(Color.cyan)
                                AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                  .foregroundStyle(Color.red)
                                AxisValueLabel() { // construct Text here
                                  if let intValue = value.as(Int.self) {
                                    Text("\(intValue) $")
                                      .font(.system(size: 10)) // style it
                                      .foregroundColor(.white)
                                  }
                                }
                              }
                            }
                            
                            .chartXAxis {
                                AxisMarks(values: .automatic) { value in
                                  AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                                    .foregroundStyle(Color.cyan)
                                  AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                    .foregroundStyle(Color.red)
                                  AxisValueLabel() { // construct Text here
                                      if let intValue = value.as(Date.self) {
                                          Text("\(intValue) $")
                                              .font(.system(size: 10)) // style it
                                              .foregroundColor(.white)
                                          
                                      }
                                  }
                                }
                            }
                            .frame(width: 350, height: 300)
                            .offset(y: -80)
                            .task {

                                    await fetchChart.fetchChart("bitcoin", from: Date().timeIntervalSince1970 - (Double(EpochUnixTime.hour.rawValue) ?? 0))

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
                                withAnimation(.easeInOut) {
                                    longIsPressed.toggle()
                                    shortIsPressed = false
                                }
                            }
                        Spacer()
                        circleStyle(_color: .purple, _typeOrder: "SHORT")
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    shortIsPressed.toggle()
                                    longIsPressed = false
                                }
                            }
                    }.padding(.horizontal, 35 )
                }
                
                //MARK: Text if long/short position are taken
                
                Group {
                    
                    if pricePosition <= endPricePosition && idPosition == "long" && endPricePosition != 0.0 {
                        Text("Bravo le pari a été gagné carrément les gars")
                    } else if pricePosition > endPricePosition && idPosition == "long" && endPricePosition != 0.0 {
                        Text("T'es nul entraîne toi encore gros lard")
                    }
                    
                }.padding()
                    
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.cyan)
                            
                    }
                    .padding(.horizontal, 25).bold()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .offset(y: UIScreen.main.bounds.height / 2)
                    
                //MARK: Display 5 cryptos
                
                //MARK: VIEW IF LONG BUTTON IS PRESSED
                if longIsPressed {
                    
                        templateTakePosition(_color: .cyan)
                            .transition(.move(edge: .leading))
                    
                }
                if shortIsPressed {
                    templateTakePosition(_color: .purple, _degree: Angle(degrees: 180))
                        .transition(.move(edge: .trailing))
                        
                }
            }.task {
                await crypto.fetchCryptoCurrency()
        }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Text("Zebi")
                        .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameView(cryptoCurrency: CryptoCurrencyModel(
                id: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?", currentPrice: 34553.45, priceChangePercentage24h: -4032.56))
            .environmentObject(FetchChartApi())
            .environmentObject(CryptoApiCall())
        }
    }
}

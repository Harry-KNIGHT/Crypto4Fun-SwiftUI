//
//  GameView.swift
//  Crypto4Fun
//
//  Created by Nyl Neuville on 31/07/2022.
//

import SwiftUI

struct GameView: View {
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
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            VStack {
                Image("GameTemplate").ignoresSafeArea()
                
                HStack {
                    circleStyle(_color: .cyan, _typeOrder: "LONG")
                        
                    Spacer()
                    circleStyle(_color: .pink, _typeOrder: "SHORT")
                }.padding(.horizontal, 35 )
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

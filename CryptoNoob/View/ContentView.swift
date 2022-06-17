//
//  ContentView.swift
//  CryptoNoob
//
//  Created by Elliot Knight on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apiCall: ApiCall
    var body: some View {
       MainView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApiCall())
    }
}

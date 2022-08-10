//
//  PlayerModel.swift
//  Crypto4Fun
//
//  Created by Nyl Neuville on 09/08/2022.
//

import Foundation


struct PlayerModel {
    let id = UUID()
    let credit: Int
    let bid: Bid
    let energy: Int
}

struct Bid {
    let bid: [Double]
    let haveWonBid: HaveWonBid
}

enum HaveWonBid {
    case won, lost
}

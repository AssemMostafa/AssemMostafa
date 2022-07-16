//
//  CandelsModel.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation

 struct MainCandelsModel: Codable {
     var result: [CandelsModel]?
}

 struct CandelsModel: Codable {

    var openTime: Int
    var open: String
    var high: String
    var low: String
    var close: String
    var volume: String
    var closeTime: Int
    var qouteAssetVolume: String
    var numberOfTrades: Int
    var takerBuyBaseAssetVolume: String
    var takerBuyQouteAssetVolume: String
    var ignore: String

     init() {
         self.close = ""
         self.open = ""
         self.low = ""
         self.high = ""
         self.close = ""
         self.volume = ""
         self.qouteAssetVolume = ""
         self.takerBuyBaseAssetVolume = ""

         self.takerBuyQouteAssetVolume = ""
         self.ignore = ""
         self.numberOfTrades = 0
         self.openTime = 0
         self.closeTime = 0

     }
}
//struct CandelsModel: Codable {
//
//    var openTime: Int
//    var open: Double
//    var high: Double
//    var low: Double
//    var close: Double
//    var volume: Double
//    var closeTime: Int
//    var qouteAssetVolume: Double
//    var numberOfTrades: Int
//    var takerBuyBaseAssetVolume: Double
//    var takerBuyQouteAssetVolume: Double
//    var ignore: Double
//
//    init?(json: [String:Any]) {
//
//        guard
//            let openTime = json["openTime"] as? Int,
//            let open = json["open"] as? Double,
//            let high = json["high"] as? Double,
//            let low = json["low"] as? Double,
//            let close = json["close"] as? Double,
//            let volume = json["volume"] as? Double,
//            let closeTime = json["closeTime"] as? Int,
//            let qouteAssetVolume = json["qouteAssetVolume"] as? Double,
//            let numberOfTrades = json["numberOfTrades"] as? Int,
//            let takerBuyBaseAssetVolume = json["takerBuyBaseAssetVolume"] as? Double,
//            let takerBuyQouteAssetVolume = json["takerBuyQouteAssetVolume"] as? Double,
//            let ignore = json["ignore"] as? Double else {return nil}
//
//        self.openTime = openTime
//        self.open = open
//        self.high = high
//        self.low = low
//        self.close = close
//        self.volume = volume
//        self.closeTime = closeTime
//        self.qouteAssetVolume = qouteAssetVolume
//        self.numberOfTrades = numberOfTrades
//        self.takerBuyBaseAssetVolume = takerBuyBaseAssetVolume
//        self.takerBuyQouteAssetVolume = takerBuyQouteAssetVolume
//        self.ignore = ignore
//
//    }
//}

//
//  HelperManger.swift
//  PriceCharts
//
//  Created by Assem on 16/07/2022.
//

import Foundation

class HelperManger {

    static var sharedInstance = HelperManger()
    private init() {}

    func convertToFinalObject(inputArr: [CandelsModel]) -> [ChartDataPair] {
        let finalDict = inputArr.map { (model) -> ChartDataPair in
            return ChartDataPair(DateTime: "\(model.openTime)", Open: model.open.toDouble() ?? 0.0, High: model.high.toDouble() ?? 0.0, Low: model.low.toDouble() ?? 0.0, Close: model.close.toDouble() ?? 0.0)
        }
        return finalDict
    }

    func getDateFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

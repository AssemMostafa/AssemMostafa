//
//  CandleStickRequests.swift
//  PriceCharts
//
//  Created by Assem on 15/07/2022.
//

import Foundation
import Alamofire

enum CandleStickRequests: NetworkRequest {

    case getCandleSticks(symbol: String, interval: String, limit: String)

    var path: String {
        switch self {
        case .getCandleSticks(let symbol, let interval, let limit):
            return "klines?symbol=\(symbol)&interval=\(interval)m&limit=\(limit)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getCandleSticks:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getCandleSticks:
            return nil

        }
    }

    var parameterEncoding: RequestParameterEncoding? {
        return .json
    }

    var multiPart: [MultipartData]? {
        return nil
    }

}
